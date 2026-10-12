from rest_framework import serializers

from .models import Transaction


class TransactionSerializer(serializers.ModelSerializer):

    card_number = serializers.CharField(
        source="card.masked_card_number",
        read_only=True
    )

    class Meta:
        model = Transaction

        fields = [
            "id",
            "transaction_id",
            "card",
            "card_number",
            "amount",
            "status",
            "created_at",
            "updated_at",
        ]

        read_only_fields = [
            "id",
            "transaction_id",
            "status",
            "created_at",
            "updated_at",
            "card_number",
        ]