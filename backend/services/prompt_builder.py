from typing import Dict, List

QUESTIONNAIRE_MAP = {
    "music": [
        # Q1: Energy level
        [
            {"tempo": "low", "energy": "low", "vibe": "acoustic|ambient", "acousticness": "high"},
            {"tempo": "medium", "energy": "medium", "vibe": "lofi|minimal|classical", "instrumentalness": "high"},
            {"tempo": "high", "energy": "high", "vibe": "dance|electronic|hip-hop", "danceability": "high"},
            {"tempo": "high|medium", "energy": "high", "vibe": "rock|metal|punk|grunge", "loudness": "high"},
        ],
        # Q2: Environment
        [
            {"aesthetic": "synthwave|dreampop|jazz", "mood": "melancholic|reflective"},
            {"aesthetic": "indie|folk|pop", "mood": "cheerful|warm"},
            {"aesthetic": "techno|house|trap", "mood": "hypnotic|intense"},
            {"aesthetic": "folk|neo-classical|ambient", "mood": "serene|isolated"},
        ],
        # Q3: Focus
        [
            {"focus": "vocal_driven", "genres": "singer-songwriter|rap|folk"},
            {"focus": "beat_driven", "genres": "edm|hip-hop|rnb"},
            {"focus": "instrumental", "genres": "ambient|post-rock|lofi"},
            {"focus": "melody_driven", "genres": "pop|funk|disco"},
        ],
        # Q4: Social connectedness
        [
            {"social_vibe": "solo|intimate", "depth": "deep", "mood": "introverted"},
            {"social_vibe": "retro|vintage", "era": "70s|80s|90s", "mood": "nostalgic"},
            {"social_vibe": "crowd-pleaser|hype", "mainstream": "high", "mood": "extroverted"},
            {"social_vibe": "alternative|indie", "underground": "high", "mood": "edgy"},
        ],
        # Q5: Era
        [
            {"era": "pre-1980", "style": "analog|acoustic|classic"},
            {"era": "1980-2000", "style": "synth-pop|grunge|90s-hiphop"},
            {"era": "2010-present", "style": "modern-production|clean"},
            {"era": "avant-garde", "style": "experimental|hyperpop|idm"},
        ],
        # Q6: Purpose
        [
            {"purpose": "focus", "vocals": "none|minimal", "distraction": "low"},
            {"purpose": "movement", "rhythm": "steady|upbeat", "drive": "high"},
            {"purpose": "sleep|meditate", "tempo": "ultra-low", "relaxing": "high"},
            {"purpose": "background_hype", "tempo": "medium-high", "feel-good": "high"},
        ],
        # Q7: Heart rate
        [
            {"arousal": "low", "soothing": "high", "dynamics": "flat"},
            {"arousal": "medium", "groove": "high", "dynamics": "consistent"},
            {"arousal": "high", "hype": "high", "dynamics": "explosive"},
            {"arousal": "variable", "cinematic": "high", "dynamics": "wide"},
        ],
    ],
    "movie": [
        # Q1: Goal
        [
            {"genre": "comedy|animation", "tone": "lighthearted", "intensity": "low"},
            {"genre": "thriller|horror|action", "tone": "tense", "intensity": "high"},
            {"genre": "mystery|sci-fi", "tone": "cerebral", "plot": "complex"},
            {"genre": "drama|romance", "tone": "emotional", "intensity": "medium"},
        ],
        # Q2: Brainpower
        [
            {"complexity": "low", "pacing": "fast", "visual_style": "blockbusters"},
            {"complexity": "medium", "pacing": "balanced", "visual_style": "mainstream"},
            {"complexity": "high", "pacing": "meticulous", "visual_style": "non-linear"},
            {"complexity": "high", "tone": "bleak|philosophical", "themes": "existential"},
        ],
        # Q3: World
        [
            {"setting": "contemporary|urban", "style": "realism|neo-noir"},
            {"setting": "futuristic|fantasy", "style": "world-building"},
            {"setting": "period_piece|historical", "style": "stylized"},
            {"setting": "suburban|small_town", "style": "slice_of_life"},
        ],
        # Q4: Suspense
        [
            {"suspense": "none", "threat_level": "low", "vibe": "wholesome"},
            {"suspense": "low", "threat_level": "medium", "vibe": "satisfying"},
            {"suspense": "high", "threat_level": "high", "vibe": "intense"},
            {"suspense": "extreme", "threat_level": "psychological", "vibe": "disturbing"},
        ],
        # Q5: Era
        [
            {"era": "2015-present", "production": "modern-high"},
            {"era": "1990-2015", "production": "practical-heavy"},
            {"era": "pre-1990", "production": "classic"},
            {"era": "any", "production": "indie|low-budget", "focus": "artistic"},
        ],
        # Q6: Audience
        [
            {"audience": "solo", "themes": "introspective|character-study"},
            {"audience": "romantic-partner", "themes": "romantic|tension|chemistry"},
            {"audience": "group", "themes": "interactive|fun|entertaining"},
            {"audience": "family", "rating": "PG|G", "themes": "broad-appeal"},
        ],
        # Q7: Pacing
        [
            {"pacing": "hyper_fast", "storytelling": "action_led"},
            {"pacing": "balanced", "storytelling": "conventional"},
            {"pacing": "slow_burn", "storytelling": "character_led"},
            {"pacing": "fluid|abstract", "storytelling": "non-linear"},
        ],
    ],
    "series": [
        # Q1: Commitment
        [
            {"format": "sitcom", "runtime": "20-30m", "serialized": "low"},
            {"format": "limited_series", "runtime": "45-60m", "serialized": "high"},
            {"format": "multi_season", "seasons": ">3", "serialized": "high"},
            {"format": "episodic|reality", "tone": "low_stakes", "comfort_watch": "true"},
        ],
        # Q2: Hook
        [
            {"hook": "cliffhanger", "pacing": "hyper_fast", "subgenre": "mystery|conspiracy"},
            {"hook": "dialogue", "pacing": "fast", "subgenre": "sitcom|dramedy"},
            {"hook": "world_politics", "pacing": "steady", "subgenre": "historical|fantasy_politics"},
            {"hook": "character_arc", "pacing": "slow_burn", "subgenre": "psychological_drama"},
        ],
        # Q3: Ending feel
        [
            {"ending": "twist|ambiguous", "resolution": "open_ended"},
            {"ending": "uplifting|resolved", "resolution": "happy_ending"},
            {"ending": "triumphant", "resolution": "inspiring"},
            {"ending": "bittersweet|tragic", "resolution": "emotional"},
        ],
        # Q4: Darkness
        [
            {"tone": "light", "themes": "optimistic|wholesome", "intensity": "low"},
            {"tone": "realistic", "themes": "balanced", "intensity": "medium"},
            {"tone": "dark", "themes": "moral-ambiguity", "intensity": "high"},
            {"tone": "grimdark", "themes": "survival|terror", "intensity": "extreme"},
        ],
        # Q5: Character dynamic
        [
            {"characters": "ensemble", "vibe": "found_family|friendship"},
            {"characters": "solo-lead", "vibe": "hero-journey|antihero"},
            {"characters": "duel", "vibe": "psychological-rivalry|crime-chase"},
            {"characters": "sprawling", "vibe": "family-saga|political-dynasty"},
        ],
        # Q6: Visuals
        [
            {"visuals": "clean|hd", "color_palette": "bright", "budget": "high"},
            {"visuals": "cinematic|shadowy", "color_palette": "dark|muted", "budget": "medium-high"},
            {"visuals": "retro|stylized", "color_palette": "warm|saturated"},
            {"visuals": "animated|surreal", "color_palette": "vibrant"},
        ],
        # Q7: World-building
        [
            {"setting": "present_day", "world_building": "zero"},
            {"setting": "magical_realism|subtle_scifi", "world_building": "light"},
            {"setting": "historical", "world_building": "medium"},
            {"setting": "high_fantasy|space_opera", "world_building": "extreme"},
        ],
    ]
}


def get_tags_from_answers(category: str, answers: List[int]) -> Dict[str, str]:
    cat = category.lower()
    if cat not in QUESTIONNAIRE_MAP:
        return {}

    questions = QUESTIONNAIRE_MAP[cat]
    tags = {}
    for i, ans_idx in enumerate(answers):
        if i < len(questions):
            if 0 <= ans_idx < len(questions[i]):
                tags.update(questions[i][ans_idx])
    return tags


def build_prompt(category: str, tags: Dict[str, str], excluded_titles: List[str] = None) -> str:
    tags_formatted = "\n".join([f"- {k}: {v}" for k, v in tags.items()])

    category_lower = category.lower()
    if category_lower == "music":
        item_description = "songs/tracks along with their artists"
        examples_str = "e.g. title: 'Starboy', subtitle: 'The Weeknd'"
    elif category_lower == "movie":
        item_description = "movies"
        examples_str = "e.g. title: 'Blade Runner 2049'"
    else:
        item_description = "TV shows/series"
        examples_str = "e.g. title: 'Severance'"

    exclusion_block = ""
    if excluded_titles:
        titles_str = ", ".join(f'"{t}"' for t in excluded_titles)
        exclusion_block = f"""
IMPORTANT — DO NOT repeat any of these previously shown titles. The user has already seen them and wants something fresh:
{titles_str}

You MUST recommend completely different {item_description} not in the above list.
"""

    prompt = f"""You are a world-class, highly personalized entertainment recommendation engine with deep knowledge of music, cinema, and television.

Based on the following 7-dimensional user preference tags — derived from a detailed questionnaire — recommend exactly 5 unique {item_description} that perfectly match the user's current mood, energy, and taste profile.

=== USER PREFERENCE PROFILE ===
{tags_formatted}
{exclusion_block}
=== RECOMMENDATION REQUIREMENTS ===

Each recommended item MUST:
1. Deeply match the user's exact vibe profile above — not just the genre, but the tone, energy, era, and purpose.
2. Be a real, well-known, high-quality title.
3. Be DISTINCT from all other recommendations in this response (no duplicates).

For each item, return:
- 'title': The official title in standard casing (e.g. {examples_str})
- 'subtitle': Artist name for music only. Empty string for movies/series.
- 'imagePath': A working HTTPS URL to the official cover art or poster.
  • For movies/series: use TMDB image URLs (https://image.tmdb.org/t/p/w500/...) or verified Wikipedia poster URLs.
  • For music: use Wikimedia Commons album art URLs or verified CDN links.
  • The URL must be real and publicly accessible — do NOT invent or guess URLs.
- 'reason': 2–3 sentences explaining exactly WHY this item fits the user's specific profile. Reference actual tag values.
- 'confidence': An integer 0–100 representing how precisely this item matches the user profile.

Respond ONLY with valid JSON. No extra text outside the JSON structure.
"""
    return prompt
