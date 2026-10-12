from django.test import TestCase

# Create your tests here.
from datetime import datetime

from django.contrib.auth.models import User
from django.utils import timezone
from rest_framework import status
from rest_framework.test import APITestCase

from cards.models import Card
from .models import Transaction


class TransactionTests(APITestCase):

    def setUp(self):
        self.user = User.objects.create_user(
            username="transactionuser",
            email="transaction@example.com",
            password="StrongPassword@123"
        )

        self.other_user = User.objects.create_user(
            username="othertransactionuser",
            email="othertransaction@example.com",
            password="StrongPassword@123"
        )

        self.card = Card.objects.create(
            user=self.user,
            card_type="CREDIT",
            masked_card_number="************1111",
            last_four="1111",
            expiry_month=12,
            expiry_year=2030
        )

        self.other_card = Card.objects.create(
            user=self.other_user,
            card_type="CREDIT",
            masked_card_number="************2222",
            last_four="2222",
            expiry_month=12,
            expiry_year=2030
        )

        self.transaction = Transaction.objects.create(
            user=self.user,
            card=self.card,
            amount=500.00,
            status="SUCCESS",
            transaction_id="TEST-TXN-001"
        )

        self.other_transaction = Transaction.objects.create(
            user=self.other_user,
            card=self.other_card,
            amount=1000.00,
            status="FAILED",
            transaction_id="TEST-TXN-002"
        )

        self.client.force_authenticate(user=self.user)

    def test_view_transaction_history(self):
        response = self.client.get(
            "/api/transactions/"
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
            response.data[0]["transaction_id"],
            "TEST-TXN-001"
        )

    def test_transaction_status_filter(self):
        response = self.client.get(
            "/api/transactions/?status=SUCCESS"
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
            response.data[0]["status"],
            "SUCCESS"
        )

    def test_transaction_amount_filter(self):
        response = self.client.get(
            "/api/transactions/?min_amount=600"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertEqual(
            len(response.data),
            0
        )

    def test_transaction_detail(self):
        response = self.client.get(
            f"/api/transactions/{self.transaction.id}/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertEqual(
            response.data["transaction_id"],
            "TEST-TXN-001"
        )

    def test_cannot_view_other_users_transaction(self):
        response = self.client.get(
            f"/api/transactions/{self.other_transaction.id}/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_404_NOT_FOUND
        )