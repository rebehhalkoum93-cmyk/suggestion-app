import json
import logging
import random
from typing import Dict, List, Any
import google.generativeai as genai
from google.generativeai.types import GenerationConfig

import config
from models.request_models import RecommendResponse, RecommendationItem

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize Gemini if key is provided
gemini_available = False
if config.GEMINI_API_KEY:
    try:
        genai.configure(api_key=config.GEMINI_API_KEY)
        gemini_available = True
        logger.info("Gemini API successfully configured.")
    except Exception as e:
        logger.error(f"Failed to configure Gemini API: {e}")
else:
    logger.warning("GEMINI_API_KEY not found. Running in Mock/Tag-Matching Engine mode.")


# --- FALLBACK / MOCK MEDIA DATABASE FOR TAG MATCHING ---
# Hand-curated library of items with rich tags mapping to recommendation_questions_and_tags.md
MOCK_DATABASE = {
    "music": [
        {
            "title": "starboy",
            "subtitle": "the weeknd",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/3/39/The_Weeknd_-_Starboy.png",
            "tags": {"tempo": "high", "energy": "high", "vibe": "dance|electronic|hip-hop", "aesthetic": "synthwave|dreampop|jazz", "focus": "beat_driven", "genres": "edm|hip-hop|rnb"}
        },
        {
            "title": "blinding lights",
            "subtitle": "the weeknd",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png",
            "tags": {"tempo": "high", "energy": "high", "vibe": "dance|electronic|hip-hop", "aesthetic": "synthwave|dreampop|jazz", "focus": "melody_driven", "genres": "pop|funk|disco"}
        },
        {
            "title": "nightcall",
            "subtitle": "kavinsky",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/5/55/Kavinsky-nightcall.jpg",
            "tags": {"tempo": "medium", "energy": "medium", "vibe": "lofi|minimal|classical", "aesthetic": "synthwave|dreampop|jazz", "focus": "instrumental", "genres": "ambient|post-rock|lofi"}
        },
        {
            "title": "instant crush",
            "subtitle": "daft punk",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/1/1f/Daft_Punk_-_Random_Access_Memories.png",
            "tags": {"tempo": "medium", "energy": "medium", "vibe": "lofi|minimal|classical", "aesthetic": "synthwave|dreampop|jazz", "focus": "melody_driven", "genres": "pop|funk|disco"}
        },
        {
            "title": "after hours",
            "subtitle": "the weeknd",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/c/c4/The_Weeknd_-_After_Hours.png",
            "tags": {"tempo": "medium", "energy": "medium", "vibe": "lofi|minimal|classical", "aesthetic": "synthwave|dreampop|jazz", "focus": "vocal_driven", "genres": "singer-songwriter|rap|folk"}
        },
        {
            "title": "one more time",
            "subtitle": "daft punk",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/a/ae/Daft_Punk_Discovery.png",
            "tags": {"tempo": "high", "energy": "high", "vibe": "dance|electronic|hip-hop", "aesthetic": "indie|folk|pop", "focus": "melody_driven", "genres": "pop|funk|disco"}
        },
        {
            "title": "harder better faster",
            "subtitle": "daft punk",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/a/ae/Daft_Punk_Discovery.png",
            "tags": {"tempo": "high", "energy": "high", "vibe": "dance|electronic|hip-hop", "aesthetic": "techno|house|trap", "focus": "beat_driven", "genres": "edm|hip-hop|rnb"}
        },
        {
            "title": "midnight city",
            "subtitle": "m83",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/d/da/Hurry_Up%2C_We%27re_Dreaming.jpg",
            "tags": {"tempo": "medium", "energy": "medium", "vibe": "lofi|minimal|classical", "aesthetic": "synthwave|dreampop|jazz", "focus": "melody_driven", "genres": "pop|funk|disco"}
        },
        {
            "title": "skinny love",
            "subtitle": "bon iver",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/a/a4/Bon_Iver_-_For_Emma%2C_Forever_Ago.jpg",
            "tags": {"tempo": "low", "energy": "low", "vibe": "acoustic|ambient", "aesthetic": "folk|neo-classical|ambient", "focus": "vocal_driven", "genres": "singer-songwriter|rap|folk"}
        },
        {
            "title": "weightless",
            "subtitle": "marconi union",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/b/be/Marconi_Union_-_Weightless.jpg",
            "tags": {"tempo": "low", "energy": "low", "vibe": "acoustic|ambient", "aesthetic": "folk|neo-classical|ambient", "focus": "instrumental", "genres": "ambient|post-rock|lofi"}
        },
        {
            "title": "master of puppets",
            "subtitle": "metallica",
            "imagePath": "https://upload.wikimedia.org/wikipedia/en/b/b2/Metallica_-_Master_of_Puppets_cover.jpg",
            "tags": {"tempo": "high", "energy": "high", "vibe": "rock|metal|punk|grunge", "aesthetic": "techno|house|trap", "focus": "beat_driven", "genres": "rock|metal|punk|grunge"}
        },
        {
            "title": "clair de lune",
            "subtitle": "claude debussy",
            "imagePath": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Claude_Debussy_at_the_piano_1893.jpg/300px-Claude_Debussy_at_the_piano_1893.jpg",
            "tags": {"tempo": "low", "energy": "low", "vibe": "acoustic|ambient", "aesthetic": "folk|neo-classical|ambient", "focus": "instrumental", "genres": "ambient|post-rock|lofi"}
        }
    ],
    "movie": [
        {
            "title": "drive",
            "imagePath": "https://image.tmdb.org/t/p/w500/602vevIURmpjJsyDBeM8s4ABwIU.jpg",
            "tags": {"genre": "thriller|horror|action", "tone": "tense", "intensity": "high", "complexity": "medium", "pacing": "balanced", "visual_style": "mainstream", "setting": "contemporary|urban", "style": "realism|neo-noir"}
        },
        {
            "title": "blade runner 2049",
            "imagePath": "https://image.tmdb.org/t/p/w500/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg",
            "tags": {"genre": "mystery|sci-fi", "tone": "cerebral", "plot": "complex", "complexity": "high", "pacing": "meticulous", "visual_style": "non-linear|puzzle", "setting": "futuristic|fantasy", "style": "world-building"}
        },
        {
            "title": "interstellar",
            "imagePath": "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
            "tags": {"genre": "mystery|sci-fi", "tone": "cerebral", "plot": "complex", "complexity": "high", "pacing": "balanced", "visual_style": "blockbusters|spectacle", "setting": "futuristic|fantasy", "style": "world-building"}
        },
        {
            "title": "the matrix",
            "imagePath": "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOKRTZBqz.jpg",
            "tags": {"genre": "thriller|horror|action", "tone": "tense", "intensity": "high", "complexity": "medium", "pacing": "fast", "visual_style": "blockbusters|spectacle", "setting": "futuristic|fantasy", "style": "world-building"}
        },
        {
            "title": "superbad",
            "imagePath": "https://image.tmdb.org/t/p/w500/ek8e8txUyUwd2BNqj6lFEerJfbq.jpg",
            "tags": {"genre": "comedy|animation", "tone": "lighthearted", "intensity": "low", "complexity": "low", "pacing": "fast", "visual_style": "mainstream", "setting": "suburban|small_town", "style": "slice_of_life"}
        },
        {
            "title": "the dark knight",
            "imagePath": "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            "tags": {"genre": "thriller|horror|action", "tone": "tense", "intensity": "high", "complexity": "high", "pacing": "fast", "visual_style": "blockbusters|spectacle", "setting": "contemporary|urban", "style": "realism|neo-noir"}
        },
        {
            "title": "inception",
            "imagePath": "https://image.tmdb.org/t/p/w500/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg",
            "tags": {"genre": "mystery|sci-fi", "tone": "cerebral", "plot": "complex", "complexity": "high", "pacing": "fast", "visual_style": "non-linear|puzzle", "setting": "futuristic|fantasy", "style": "world-building"}
        },
        {
            "title": "eternal sunshine of the spotless mind",
            "imagePath": "https://image.tmdb.org/t/p/w500/5MwkWH9tYHv3mV9OqYRKFQSh.jpg",
            "tags": {"genre": "drama|romance", "tone": "emotional", "intensity": "medium", "complexity": "high", "pacing": "balanced", "visual_style": "non-linear|puzzle", "setting": "suburban|small_town", "style": "slice_of_life"}
        },
        {
            "title": "parasite",
            "imagePath": "https://image.tmdb.org/t/p/w500/7IiTTgloROVKhNpbyr6d7yOwuKD.jpg",
            "tags": {"genre": "thriller|horror|action", "tone": "cerebral", "plot": "complex", "complexity": "high", "pacing": "balanced", "visual_style": "non-linear|puzzle", "setting": "contemporary|urban", "style": "realism|neo-noir"}
        },
        {
            "title": "everything everywhere all at once",
            "imagePath": "https://image.tmdb.org/t/p/w500/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg",
            "tags": {"genre": "comedy|animation", "tone": "emotional", "intensity": "medium", "complexity": "high", "pacing": "fast", "visual_style": "non-linear|puzzle", "setting": "contemporary|urban", "style": "world-building"}
        }
    ],
    "series": [
        {
            "title": "severance",
            "imagePath": "https://image.tmdb.org/t/p/w500/HnAZHH2H6bfm9jGVBH9D1dfOMPM.jpg",
            "tags": {"format": "limited_series", "runtime": "45-60m", "serialized": "high", "hook": "character_arc", "pacing": "slow_burn", "subgenre": "psychological_drama", "ending": "twist|ambiguous", "resolution": "open_ended"}
        },
        {
            "title": "black mirror",
            "imagePath": "https://image.tmdb.org/t/p/w500/7PRddO7z7MCVLKScKhn6BfedcI6.jpg",
            "tags": {"format": "procedural|sitcom", "runtime": "45-60m", "serialized": "low", "hook": "cliffhanger", "pacing": "hyper_fast", "subgenre": "mystery|conspiracy", "ending": "twist|ambiguous", "resolution": "open_ended"}
        },
        {
            "title": "stranger things",
            "imagePath": "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
            "tags": {"format": "multi_season", "seasons": ">3", "serialized": "high", "hook": "cliffhanger", "pacing": "fast", "subgenre": "mystery|conspiracy", "ending": "triumphant", "resolution": "inspiring"}
        },
        {
            "title": "friends",
            "imagePath": "https://image.tmdb.org/t/p/w500/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
            "tags": {"format": "procedural|sitcom", "runtime": "20-30m", "serialized": "low", "hook": "dialogue", "pacing": "fast", "subgenre": "sitcom|dramedy", "ending": "uplifting|resolved", "resolution": "happy_ending"}
        },
        {
            "title": "sherlock",
            "imagePath": "https://image.tmdb.org/t/p/w500/7WTsnHkbA0FaG6R9twfFde0I9hl.jpg",
            "tags": {"format": "limited_series", "runtime": "45-60m", "serialized": "high", "hook": "dialogue", "pacing": "fast", "subgenre": "mystery|conspiracy", "ending": "twist|ambiguous", "resolution": "open_ended"}
        },
        {
            "title": "the bear",
            "imagePath": "https://image.tmdb.org/t/p/w500/7GrxPDaCNJnvpJBMwRBNSITrTRX.jpg",
            "tags": {"format": "limited_series", "runtime": "30-45m", "serialized": "high", "hook": "character_arc", "pacing": "hyper_fast", "subgenre": "psychological_drama", "ending": "bittersweet|tragic", "resolution": "emotional"}
        },
        {
            "title": "dark",
            "imagePath": "https://image.tmdb.org/t/p/w500/apbrbWs8M9lyOpJYU5IgDY1oAMz.jpg",
            "tags": {"format": "multi_season", "seasons": ">3", "serialized": "high", "hook": "cliffhanger", "pacing": "slow_burn", "subgenre": "mystery|conspiracy", "ending": "twist|ambiguous", "resolution": "open_ended"}
        },
        {
            "title": "succession",
            "imagePath": "https://image.tmdb.org/t/p/w500/e2X4vnHB79Vck7RJmuKCRquXaOD.jpg",
            "tags": {"format": "multi_season", "seasons": ">3", "serialized": "high", "hook": "world_politics", "pacing": "steady", "subgenre": "historical|fantasy_politics", "ending": "bittersweet|tragic", "resolution": "emotional"}
        },
        {
            "title": "the office",
            "imagePath": "https://image.tmdb.org/t/p/w500/7DJKHzAi83BmQrWLrYYOqcoKfhR.jpg",
            "tags": {"format": "episodic|reality", "tone": "low_stakes", "comfort_watch": "true", "hook": "dialogue", "pacing": "fast", "subgenre": "sitcom|dramedy", "ending": "uplifting|resolved", "resolution": "happy_ending"}
        }
    ]
}


def calculate_match_score(item_tags: Dict[str, str], query_tags: Dict[str, str]) -> float:
    """
    Calculates a match coefficient between database item tags and user selected tags.
    Handles multi-valued tags joined by '|' (e.g. 'acoustic|ambient').
    """
    score = 0.0
    for key, query_val in query_tags.items():
        if key in item_tags:
            item_val = item_tags[key]
            
            # Split tags to support multiple values (e.g. 'acoustic|ambient')
            query_vals = set(query_val.split('|'))
            item_vals = set(item_val.split('|'))
            
            # Calculate intersection
            intersection = query_vals.intersection(item_vals)
            if intersection:
                score += 1.0  # Base match
                score += (len(intersection) * 0.1)  # Bonus for multiple match overlaps
    return score


def get_local_recommendations(category: str, tags: Dict[str, str], excluded_titles: list = None) -> RecommendResponse:
    """
    Returns recommendations from the local mock database.
    Picks 5 randomly from the top-8 scoring matches, skipping any excluded titles.
    """
    cat = category.lower()
    database = MOCK_DATABASE.get(cat, MOCK_DATABASE["music"])
    excluded_lower = {t.lower().strip() for t in (excluded_titles or [])}

    # Score all non-excluded items
    scored_items = []
    for item in database:
        if item["title"].lower() in excluded_lower:
            continue
        score = calculate_match_score(item["tags"], tags)
        scored_items.append((score, item))

    # If we excluded too many and don't have enough, allow excluded ones back
    if len(scored_items) < 5:
        for item in database:
            if item["title"].lower() in excluded_lower:
                score = calculate_match_score(item["tags"], tags)
                scored_items.append((score, item))

    # Sort by score descending
    scored_items.sort(key=lambda x: x[0], reverse=True)

    # Take top-8, shuffle, pick 5 — guarantees different results each call
    pool_size = min(8, len(scored_items))
    top_pool = scored_items[:pool_size]
    random.shuffle(top_pool)
    selected = top_pool[:5]

    recommendations = []
    for score, item in selected:
        max_possible_score = len(tags) if tags else 1.0
        confidence = int(min(100, max(50, (score / max_possible_score) * 100)))

        if cat == "music":
            reason = f"An excellent {item['tags'].get('vibe', 'vocal')} track with a {item['tags'].get('tempo', 'medium')} tempo to fit your mood."
        elif cat == "movie":
            reason = f"A {item['tags'].get('tone', 'gripping')} {item['tags'].get('genre', 'cinematic')} movie with a {item['tags'].get('setting', 'immersive')} setting."
        else:
            reason = f"A highly engaging {item['tags'].get('format', 'show')} with a {item['tags'].get('pacing', 'absorbing')} pace and {item['tags'].get('hook', 'cliffhanger')} hook."

        recommendations.append(
            RecommendationItem(
                title=item["title"],
                subtitle=item.get("subtitle"),
                imagePath=item["imagePath"],
                reason=reason,
                confidence=confidence
            )
        )

    return RecommendResponse(recommendations=recommendations)


RECOMMEND_RESPONSE_SCHEMA = {
    "type": "OBJECT",
    "properties": {
        "recommendations": {
            "type": "ARRAY",
            "description": "List of recommended media items",
            "items": {
                "type": "OBJECT",
                "properties": {
                    "title": {
                        "type": "STRING",
                        "description": "The title of the track, movie, or series"
                    },
                    "subtitle": {
                        "type": "STRING",
                        "description": "The artist name. Only populated if category is 'music', otherwise null or empty string"
                    },
                    "imagePath": {
                        "type": "STRING",
                        "description": "A valid public HTTPS URL to the cover art or poster image"
                    },
                    "reason": {
                        "type": "STRING",
                        "description": "A short, personalized explanation of why this item fits the user's vibe"
                    },
                    "confidence": {
                        "type": "INTEGER",
                        "description": "Confidence score from 0 to 100"
                    }
                },
                "required": ["title", "imagePath", "reason", "confidence"]
            }
        }
    },
    "required": ["recommendations"]
}


# --- GEMINI CLIENT GENERATOR ---
def get_recommendations(category: str, prompt: str, tags: Dict[str, str], excluded_titles: list = None) -> RecommendResponse:
    """
    Invokes the Google Gemini API with strict structured schema validation.
    If the API call fails or the key is not set, falls back to the Tag Matching Engine.
    Both paths respect excluded_titles to prevent repeat suggestions.
    """
    if not gemini_available:
        logger.info("Gemini API not configured, defaulting to Local Tag-Matching Engine.")
        return get_local_recommendations(category, tags, excluded_titles=excluded_titles)

    try:
        logger.info(f"Invoking Gemini Model '{config.GEMINI_MODEL}' with structured output schema...")
        model = genai.GenerativeModel(config.GEMINI_MODEL)

        response = model.generate_content(
            prompt,
            generation_config=GenerationConfig(
                response_mime_type="application/json",
                response_schema=RECOMMEND_RESPONSE_SCHEMA,
                temperature=0.9,
            )
        )

        response_text = response.text.strip()
        logger.info(f"Gemini raw response: {response_text}")

        data = json.loads(response_text)
        result = RecommendResponse(**data)

        # Post-filter: remove any excluded titles Gemini may have hallucinated back
        if excluded_titles:
            excluded_lower = {t.lower().strip() for t in excluded_titles}
            result.recommendations = [
                r for r in result.recommendations
                if r.title.lower().strip() not in excluded_lower
            ]

        return result

    except Exception as e:
        logger.error(f"Error calling Gemini API: {e}. Falling back to Tag-Matching Engine.", exc_info=True)
        return get_local_recommendations(category, tags, excluded_titles=excluded_titles)
