from datetime import datetime

from rest_framework import serializers

from .models import Card


class CardSerializer(serializers.ModelSerializer):

    card_number = serializers.CharField(
        write_only=True,
        min_length=13,
        max_length=19
    )

    class Meta:
        model = Card

        fields = [
            "id",
            "card_type",
            "card_number",
            "masked_card_number",
            "last_four",
            "expiry_month",
            "expiry_year",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "masked_card_number",
            "last_four",
            "created_at",
        ]

    def validate_card_number(self, value):

        if not value.isdigit():
            raise serializers.ValidationError(
                "Card number must contain only digits."
            )

        if not 13 <= len(value) <= 19:
            raise serializers.ValidationError(
                "Card number must contain between 13 and 19 digits."
            )

        # Luhn algorithm validation
        digits = [int(digit) for digit in value]

        checksum = 0
        parity = len(digits) % 2

        for index, digit in enumerate(digits):
            if index % 2 == parity:
                digit = digit * 2

                if digit > 9:
                    digit = digit - 9

            checksum += digit

        if checksum % 10 != 0:
            raise serializers.ValidationError(
                "Invalid card number."
            )

        return value

    def validate_expiry_month(self, value):

        if value < 1 or value > 12:
            raise serializers.ValidationError(
                "Expiry month must be between 1 and 12."
            )

        return value

    def validate(self, attrs):

        expiry_month = attrs["expiry_month"]
        expiry_year = attrs["expiry_year"]

        current_date = datetime.now()

        if expiry_year < current_date.year:
            raise serializers.ValidationError(
                {
                    "expiry_year": "Card has already expired."
                }
            )

        if (
            expiry_year == current_date.year
            and expiry_month < current_date.month
        ):
            raise serializers.ValidationError(
                {
                    "expiry_month": "Card has already expired."
                }
            )

        return attrs

    def create(self, validated_data):

        card_number = validated_data.pop("card_number")

        last_four = card_number[-4:]

        masked_card_number = (
            "*" * (len(card_number) - 4)
            + last_four
        )

        card = Card.objects.create(
            user=self.context["request"].user,
            masked_card_number=masked_card_number,
            last_four=last_four,
            **validated_data
        )

        return card