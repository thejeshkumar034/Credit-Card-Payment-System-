# from django.test import TestCase

from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase

from .models import Card


class CardManagementTests(APITestCase):

    def setUp(self):
        self.user = User.objects.create_user(
            username="carduser",
            email="card@example.com",
            password="StrongPassword@123"
        )

        self.other_user = User.objects.create_user(
            username="otheruser",
            email="other@example.com",
            password="StrongPassword@123"
        )

        self.client.force_authenticate(user=self.user)

    def test_create_card(self):
        data = {
            "card_type": "CREDIT",
            "card_number": "4111111111111111",
            "expiry_month": 12,
            "expiry_year": 2030
        }

        response = self.client.post(
            "/api/cards/",
            data,
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

        card = Card.objects.get(user=self.user)

        self.assertEqual(
            card.last_four,
            "1111"
        )

        self.assertEqual(
            card.masked_card_number,
            "************1111"
        )

    def test_full_card_number_is_not_stored(self):
        data = {
            "card_type": "CREDIT",
            "card_number": "4111111111111111",
            "expiry_month": 12,
            "expiry_year": 2030
        }

        self.client.post(
            "/api/cards/",
            data,
            format="json"
        )

        card = Card.objects.get(user=self.user)

        self.assertFalse(
            hasattr(card, "card_number")
        )

        self.assertNotIn(
            "4111111111111111",
            card.masked_card_number
        )

    def test_view_only_own_cards(self):
        Card.objects.create(
            user=self.user,
            card_type="CREDIT",
            masked_card_number="************1111",
            last_four="1111",
            expiry_month=12,
            expiry_year=2030
        )

        Card.objects.create(
            user=self.other_user,
            card_type="DEBIT",
            masked_card_number="************2222",
            last_four="2222",
            expiry_month=12,
            expiry_year=2030
        )

        response = self.client.get(
            "/api/cards/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertEqual(
            len(response.data),
            1
        )

        self.assertEqual(
            response.data[0]["last_four"],
            "1111"
        )

    def test_delete_own_card(self):
        card = Card.objects.create(
            user=self.user,
            card_type="CREDIT",
            masked_card_number="************1111",
            last_four="1111",
            expiry_month=12,
            expiry_year=2030
        )

        response = self.client.delete(
            f"/api/cards/{card.id}/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_204_NO_CONTENT
        )

        self.assertFalse(
            Card.objects.filter(id=card.id).exists()
        )

    def test_cannot_delete_other_users_card(self):
        card = Card.objects.create(
            user=self.other_user,
            card_type="CREDIT",
            masked_card_number="************2222",
            last_four="2222",
            expiry_month=12,
            expiry_year=2030
        )

        response = self.client.delete(
            f"/api/cards/{card.id}/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_404_NOT_FOUND
        )
