
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from drf_spectacular.utils import extend_schema

from .models import Card
from .serializers import CardSerializer


class CardListCreateView(generics.ListCreateAPIView):
    serializer_class = CardSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Card.objects.filter(
            user=self.request.user
        ).order_by("-created_at")

    @extend_schema(
        summary="List saved cards",
        description="Retrieve the authenticated user's saved cards."
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

    @extend_schema(
        summary="Add payment card",
        description="Save a payment card for the authenticated user."
    )
    def post(self, request, *args, **kwargs):
        return super().post(request, *args, **kwargs)


class CardDetailView(generics.RetrieveDestroyAPIView):
    serializer_class = CardSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Card.objects.filter(
            user=self.request.user
        )

    @extend_schema(
        summary="View saved card",
        description="Retrieve a saved card belonging to the authenticated user."
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

    @extend_schema(
        summary="Delete saved card",
        description="Delete a saved card belonging to the authenticated user."
    )
    def delete(self, request, *args, **kwargs):
        return super().delete(request, *args, **kwargs)