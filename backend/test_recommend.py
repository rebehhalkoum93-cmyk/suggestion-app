import sys
import os
from fastapi.testclient import TestClient

# Add current folder to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    print("Health check endpoint: PASSED")

def test_music_recommendation():
    # Test music recommendations with answer indices
    payload = {
        "category": "music",
        "answers": [0, 1, 2]
    }
    response = client.post("/recommend", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert "recommendations" in data
    recommendations = data["recommendations"]
    assert len(recommendations) > 0
    
    # Check fields
    for rec in recommendations:
        assert "title" in rec
        assert "subtitle" in rec
        assert "imagePath" in rec
        assert "reason" in rec
        assert "confidence" in rec
        assert rec["imagePath"].startswith("http")
    
    print(f"Music recommendations endpoint: PASSED. Got {len(recommendations)} recommendations.")
    print("Example recommendation:", recommendations[0])

def test_movie_recommendation():
    # Test movie recommendations with raw tags
    payload = {
        "category": "movie",
        "tags": {
            "genre": "thriller",
            "setting": "futuristic"
        }
    }
    response = client.post("/recommend", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert "recommendations" in data
    recommendations = data["recommendations"]
    assert len(recommendations) > 0
    
    for rec in recommendations:
        assert "title" in rec
        assert "imagePath" in rec
        assert rec["imagePath"].startswith("http")
        
    print(f"Movie recommendations endpoint: PASSED. Got {len(recommendations)} recommendations.")

def test_series_recommendation():
    payload = {
        "category": "series",
        "answers": [2, 0, 1]
    }
    response = client.post("/recommend", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert "recommendations" in data
    recommendations = data["recommendations"]
    assert len(recommendations) > 0
    
    for rec in recommendations:
        assert "title" in rec
        assert "imagePath" in rec
        assert rec["imagePath"].startswith("http")
        
    print(f"Series recommendations endpoint: PASSED. Got {len(recommendations)} recommendations.")

if __name__ == "__main__":
    print("Starting tests...")
    try:
        test_health()
        test_music_recommendation()
        test_movie_recommendation()
        test_series_recommendation()
        print("\nAll tests completed successfully!")
    except Exception as e:
        print(f"\nTest failed with error: {e}")
        sys.exit(1)
