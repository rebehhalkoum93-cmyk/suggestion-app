import os
from dotenv import load_dotenv

# Load environment variables from .env file if it exists
load_dotenv()

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "")
GEMINI_MODEL = os.getenv("GEMINI_MODEL", "gemini-1.5-flash")

# FastAPI Settings
HOST = os.getenv("HOST", "0.0.0.0")
PORT = int(os.getenv("PORT", "8080")) # Fallback to 8080 or railway assigned port

# CORS settings - allow all by default for easy local frontend development
ALLOWED_ORIGINS = ["*"]
