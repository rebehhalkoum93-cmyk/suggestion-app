# AI Entertainment Recommender - Project Plan

## Overview

A Flutter application that recommends **movies, TV series, or music**
based on a user's mood and preferences. Users answer **multiple-choice
questions only**. The backend sends a structured prompt to an AI model
(Gemini), which returns personalized recommendations in JSON.

## Architecture

``` text
Flutter App
    |
HTTP POST
    |
FastAPI Backend
    |
Gemini API
    |
JSON Recommendations
    |
Flutter UI
```

## User Flow

1.  Open app
2.  Select recommendation type (Movie / Series / Music / Surprise)
3.  Answer multiple-choice questions
4.  Flutter sends answers as JSON to backend
5.  Backend builds a prompt
6.  Gemini returns recommendations in JSON
7.  Flutter displays recommendation cards

## Example Questions

-   Mood
-   Goal (Relax, Laugh, Think...)
-   Time available
-   Genre
-   Alone or with friends
-   Energy level

## Request Example

``` json
{
  "type": "movie",
  "answers": {
    "mood": "Happy",
    "energy": "High",
    "genre": "Action",
    "time": "2h",
    "company": "Friends"
  }
}
```

## Prompt Template

``` text
You are an entertainment recommendation assistant.

Recommend exactly 5 items.
Match the user's mood and preferences.
Return ONLY valid JSON.

User:
- Mood: Happy
- Energy: High
- Genre: Action
- Time: 2 hours
- Company: Friends
```

## Expected Response

``` json
{
  "recommendations": [
    {
      "title": "Top Gun: Maverick",
      "reason": "High-energy action for a fun group watch.",
      "confidence": 96
    }
  ]
}
```

## Backend Structure

``` text
backend/
├── main.py
├── routes/
│   └── recommend.py
├── services/
│   ├── gemini_service.py
│   └── prompt_builder.py
├── models/
│   └── request_models.py
└── config.py
```

## Flutter Structure

``` text
lib/
├── models/
├── services/
├── providers/
├── screens/
├── widgets/
└── utils/
```

## Development Roadmap

### Phase 1

-   Build FastAPI backend
-   Create `/recommend` endpoint
-   Test with Postman

### Phase 2

-   Integrate Gemini API
-   Build dynamic prompt
-   Return structured JSON

### Phase 3

-   Connect Flutter to backend
-   Parse JSON
-   Display recommendation cards

### Phase 4 (Optional)

-   Integrate TMDb for posters/details
-   Integrate Spotify/Last.fm for music metadata
-   Add favorites and history

## Recommended Stack

-   Flutter
-   Riverpod
-   Dio
-   FastAPI
-   Gemini API
-   TMDb API
-   Spotify API or Last.fm
-   Hive (local storage)

## Best Practices

-   Never expose AI API keys in Flutter.
-   Keep prompt generation in the backend.
-   Always request JSON-only responses.
-   Validate AI responses before sending them to Flutter.
