from fastapi import APIRouter, HTTPException

from models.request_models import RecommendRequest, RecommendResponse
from services.prompt_builder import get_tags_from_answers, build_prompt
from services.gemini_service import get_recommendations

router = APIRouter()

@router.post("/recommend", response_model=RecommendResponse)
async def recommend(request: RecommendRequest):
    """
    Generate recommendations based on category and answers or tags.
    Accepts an optional excluded_titles list to prevent repeats on regenerate.
    """
    category_lower = request.category.strip().lower()
    if category_lower not in ["music", "movie", "series"]:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid category '{request.category}'. Must be 'music', 'movie', or 'series'."
        )

    # 1. Resolve tags from answers if present
    tags = {}
    if request.answers is not None:
        tags = get_tags_from_answers(category_lower, request.answers)

    # 2. Merge with explicit tags if provided
    if request.tags is not None:
        tags.update(request.tags)

    # 3. Fallback default if nothing specified
    if not tags:
        tags = {"tempo": "medium", "energy": "medium"}

    # 4. Normalise excluded titles to lowercase for reliable comparison
    excluded = [t.lower().strip() for t in (request.excluded_titles or [])]

    # 5. Build prompt (Gemini will receive the exclusion instruction)
    prompt = build_prompt(request.category, tags, excluded_titles=excluded)

    # 6. Fetch recommendations (Gemini or local fallback, both respect exclusions)
    recommendations_response = get_recommendations(request.category, prompt, tags, excluded_titles=excluded)

    return recommendations_response
