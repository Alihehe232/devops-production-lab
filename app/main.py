import os
from fastapi import FastAPI, Response

app = FastAPI(title="Production Delivery Platform API", version="1.4.2")

APP_VERSION = os.getenv("APP_VERSION", "1.4.2")
COMMIT_HASH = os.getenv("COMMIT_HASH", "local")
ENVIRONMENT = os.getenv("ENVIRONMENT", "production")

@app.get("/health", status_code=200)
async def health_check():
    return {"status": "healthy"}

@app.get("/api/version")
async def get_version():
    return {
        "version": APP_VERSION,
        "commit": COMMIT_HASH,
        "environment": ENVIRONMENT
    }

@app.get("/api/users")
async def get_users():
    return [
        {"id": 1, "name": "DevOps Engineer"},
        {"id": 2, "name": "SRE Specialist"}
    ]
