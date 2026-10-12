
import json
from urllib.error import URLError
from urllib.request import urlopen

from django.http import JsonResponse
from drf_spectacular.generators import SchemaGenerator


FASTAPI_SCHEMA_URL = "http://127.0.0.1:8001/openapi.json"


def rename_security_scheme(obj):
    """Use one shared BearerAuth name across both APIs."""
    if isinstance(obj, dict):
        if isinstance(obj.get("security"), list):
            updated_security = []

            for requirement in obj["security"]:
                if isinstance(requirement, dict):
                    updated_security.append({
                        (
                            "BearerAuth"
                            if name in ("jwtAuth", "HTTPBearer")
                            else name
                        ): scopes
                        for name, scopes in requirement.items()
                    })
                else:
                    updated_security.append(requirement)

            obj["security"] = updated_security

        for value in obj.values():
            rename_security_scheme(value)

    elif isinstance(obj, list):
        for item in obj:
            rename_security_scheme(item)


def combined_openapi_schema(request):
    # Generate the Django API schema.
    django_schema = SchemaGenerator().get_schema(
        request=None,
        public=True,
    )

    if django_schema is None:
        return JsonResponse(
            {"error": "Could not generate the Django API schema."},
            status=500,
        )

    # Retrieve the FastAPI schema.
    try:
        with urlopen(FASTAPI_SCHEMA_URL, timeout=5) as response:
            fastapi_schema = json.loads(
                response.read().decode("utf-8")
            )

    except (URLError, TimeoutError, OSError, json.JSONDecodeError):
        return JsonResponse(
            {
                "error": "Could not retrieve the FastAPI schema.",
                "detail": "Make sure FastAPI is running on port 8001.",
            },
            status=503,
        )

    # Combine schema metadata.
    combined_schema = dict(django_schema)
    combined_schema["info"] = {
        "title": "Credit Card Payment System",
        "version": "1.0.0",
        "description": (
            "Django REST Framework and FastAPI documentation."
        ),
    }

    # Combine endpoint paths.
    combined_paths = dict(django_schema.get("paths", {}))

    for path, path_item in fastapi_schema.get("paths", {}).items():
        fastapi_path_item = dict(path_item)
        fastapi_path_item["servers"] = [
            {"url": "http://127.0.0.1:8001"}
        ]
        combined_paths[path] = fastapi_path_item

    combined_schema["paths"] = combined_paths

    # Combine components.
    django_components = django_schema.get("components", {})
    fastapi_components = fastapi_schema.get("components", {})

    combined_components = dict(django_components)

    for component_type, definitions in fastapi_components.items():
        existing = dict(
            combined_components.get(component_type, {})
        )
        existing.update(definitions)
        combined_components[component_type] = existing

    combined_schema["components"] = combined_components

    # Normalize authentication requirements.
    rename_security_scheme(combined_schema)

    security_schemes = combined_components.setdefault(
        "securitySchemes", {}
    )

    security_schemes.pop("jwtAuth", None)
    security_schemes.pop("HTTPBearer", None)

    security_schemes["BearerAuth"] = {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "JWT",
    }

   
    # Collect tags from the existing schema and endpoint definitions.
    tags_by_name = {}

    for tag in (
        django_schema.get("tags", [])
        + fastapi_schema.get("tags", [])
    ):
        if tag.get("name"):
            tags_by_name[tag["name"]] = tag

    # Collect tags directly from every endpoint.
    for path_item in combined_schema.get("paths", {}).values():
        for method, operation in path_item.items():
            if method.lower() not in {
                "get", "post", "put", "patch", "delete",
                "options", "head", "trace",
            }:
                continue

            for tag_name in operation.get("tags", []):
                if tag_name not in tags_by_name:
                    tags_by_name[tag_name] = {
                        "name": tag_name
                    }

    # Put authentication endpoints first.
    tag_order = [
        "auth",
        "cards",
        "Payments",
        "transactions",
        "Admin",
    ]

    ordered_names = [
        name for name in tag_order
        if name in tags_by_name
    ]

    # Keep all remaining tags afterward.
    ordered_names.extend(
        name for name in tags_by_name
        if name not in ordered_names
    )

    combined_schema["tags"] = [
        tags_by_name[name] for name in ordered_names
    ]

    return JsonResponse(combined_schema)