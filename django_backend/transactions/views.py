
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from drf_spectacular.utils import extend_schema

from .filters import TransactionFilter
from .models import Transaction
from .serializers import TransactionSerializer


class TransactionListView(generics.ListAPIView):
    serializer_class = TransactionSerializer
    permission_classes = [IsAuthenticated]
    filterset_class = TransactionFilter

    @extend_schema(
        summary="List transactions",
        description=(
            "Retrieve the authenticated user's transactions. "
            "Supports filtering using TransactionFilter."
        ),
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

    def get_queryset(self):
        return Transaction.objects.filter(
            user=self.request.user
        ).select_related(
            "card"
        ).order_by(
            "-created_at"
        )


class TransactionDetailView(generics.RetrieveAPIView):
    serializer_class = TransactionSerializer
    permission_classes = [IsAuthenticated]

    @extend_schema(
        summary="View transaction details",
        description=(
            "Retrieve details of a transaction belonging "
            "to the authenticated user."
        ),
    )
    def get(self, request, *args, **kwargs):
        return super().get(request, *args, **kwargs)

    def get_queryset(self):
        return Transaction.objects.filter(
            user=self.request.user
        ).select_related(
            "card"
        )