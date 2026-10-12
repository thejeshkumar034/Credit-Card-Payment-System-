from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routers.payments import router as payment_router


app = FastAPI(
    title="Credit Card Payment System",
    description="FastAPI Payment Processing Service",
    version="1.0.0",
)

# Allow the local Django-hosted Swagger UI to call FastAPI.
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://127.0.0.1:8000",
        "http://localhost:8000",
        
    ],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(payment_router)
