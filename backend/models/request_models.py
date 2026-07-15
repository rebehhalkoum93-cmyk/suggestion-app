from pydantic import BaseModel, Field
from typing import Dict, List, Optional

class RecommendRequest(BaseModel):
    category: str = Field(..., description="The category of media to recommend: 'music', 'movie', or 'series'")
    answers: Optional[List[int]] = Field(None, description="The list of 0-based selected answer indices for the questions in that category")
    tags: Optional[Dict[str, str]] = Field(None, description="Pre-aggregated key-value tags from the frontend")
    excluded_titles: Optional[List[str]] = Field(None, description="Titles already shown to the user that must NOT appear in the new response")

class RecommendationItem(BaseModel):
    title: str = Field(..., description="The title of the track, movie, or series")
    subtitle: Optional[str] = Field(None, description="The artist name. Only populated if category is 'music', otherwise null or empty")
    imagePath: str = Field(..., description="Path to the cover/poster image, e.g., 'assets/images/music_cover.png'")
    reason: str = Field(..., description="A short, personalized explanation of why this item was recommended based on the user's vibe and mood")
    confidence: int = Field(..., description="Confidence score from 0 to 100 matching how well this item fits the user's tags")

class RecommendResponse(BaseModel):
    recommendations: List[RecommendationItem] = Field(..., description="List of recommended media items")
