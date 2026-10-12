from django.contrib import admin
from django.urls import include, path

from drf_spectacular.views import (
    SpectacularSwaggerView,
    SpectacularRedocView,
)

from api_docs.views import combined_openapi_schema
from transactions.summary_views import daily_payment_summary


urlpatterns = [

    # Authentication APIs
    path(
        "api/auth/",
        include("users.urls"),
    ),
    
    path("api/admin/", include("admin_api.urls")),
    
    # Admin daily summary
    path(
        "admin/daily-summary/",
        daily_payment_summary,
        name="daily-payment-summary",
    ),
    
    # Django admin
     path(
        "admin/",
        admin.site.urls,
    ),

    # Card management APIs
    path(
        "api/cards/",
        include("cards.urls"),
    ),

    # Transaction APIs
    path(
        "api/transactions/",
        include("transactions.urls"),
    ),

    # Combined Django + FastAPI OpenAPI schema
    path(
        "api/schema/",
        combined_openapi_schema,
        name="schema",
    ),

    # Unified Swagger UI
    path(
        "api/docs/",
        SpectacularSwaggerView.as_view(url_name="schema"),
        name="swagger-ui",
    ),

    # Unified ReDoc
    path(
        "api/redoc/",
        SpectacularRedocView.as_view(url_name="schema"),
        name="redoc",
    ),
]