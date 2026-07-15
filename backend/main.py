import uvicorn
from fastapi import FastAPI

from fastapi.middleware.cors import CORSMiddleware

import config
from routes import recommend

app = FastAPI(
    title="AI Entertainment Recommender Backend",
    description="FastAPI backend serving structured recommendations from Gemini with local fallback tag matching.",
    version="1.0.0"
)

# Set up CORS middleware to allow calls from Flutter (web, mobile, or desktop)
app.add_middleware(
    CORSMiddleware,
    allow_origins=config.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(recommend.router, tags=["Recommendations"])

@app.get("/health", tags=["Health"])
async def health_check():
    """
    Standard health check endpoint to verify backend service state.
    """
    return {
        "status": "healthy",
        "gemini_api_configured": bool(config.GEMINI_API_KEY),
        "model": config.GEMINI_MODEL
    }

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host=config.HOST,
        port=config.PORT,
        reload=True
    )
