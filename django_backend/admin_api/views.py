
import csv

from django.db.models import Count, Sum, Q
from django.http import HttpResponse
from django.utils import timezone

from rest_framework import serializers
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from rest_framework.views import APIView

from drf_spectacular.utils import extend_schema

from transactions.models import Transaction
from audit_logs.models import AdminLog


class DailySummarySerializer(serializers.Serializer):
    date = serializers.DateField()
    total_transactions = serializers.IntegerField()
    success_count = serializers.IntegerField()
    failed_count = serializers.IntegerField()
    pending_count = serializers.IntegerField()
    total_success_amount = serializers.DecimalField(
        max_digits=12,
        decimal_places=2,
    )


class AdminSummaryView(APIView):
    permission_classes = [IsAdminUser]

    @extend_schema(
        tags=["Admin"],
        summary="Get today's payment summary",
        responses=DailySummarySerializer,
    )
    def get(self, request):
        today = timezone.localdate()

        transactions = Transaction.objects.filter(
            created_at__date=today
        )

        summary = transactions.aggregate(
            total_transactions=Count("id"),
            total_success_amount=Sum(
                "amount",
                filter=Q(status="SUCCESS"),
            ),
        )

        result = {
            "date": today,
            "total_transactions": summary["total_transactions"] or 0,
            "success_count": transactions.filter(
                status="SUCCESS"
            ).count(),
            "failed_count": transactions.filter(
                status="FAILED"
            ).count(),
            "pending_count": transactions.filter(
                status="PENDING"
            ).count(),
            "total_success_amount": (
                summary["total_success_amount"] or 0
            ),
        }

        return Response(result)


class AdminTransactionExportView(APIView):
    permission_classes = [IsAdminUser]

    @extend_schema(
        tags=["Admin"],
        summary="Export transactions to CSV",
        responses={(200, "text/csv"): None},
    )
    def get(self, request):
        response = HttpResponse(
            content_type="text/csv"
        )
        response["Content-Disposition"] = (
            'attachment; filename="transactions.csv"'
        )

        writer = csv.writer(response)
        writer.writerow([
            "Transaction ID",
            "User ID",
            "Card ID",
            "Amount",
            "Status",
            "Created At",
        ])

        transactions = Transaction.objects.all().order_by(
            "-created_at"
        )

        for transaction in transactions.iterator():
            writer.writerow([
                transaction.transaction_id,
                transaction.user_id,
                transaction.card_id,
                transaction.amount,
                transaction.status,
                transaction.created_at,
            ])

        return response


class AdminLogsView(APIView):
    permission_classes = [IsAdminUser]

    @extend_schema(
        tags=["Admin"],
        summary="View admin activity logs",
        responses={
            200: serializers.ListSerializer(
                child=serializers.DictField()
            )
        },
    )
    def get(self, request):
        logs = AdminLog.objects.all().order_by("-created_at")[:100]

        data = [
            {
                "id": log.id,
                "admin_user_id": log.admin_user_id,
                "action": log.action,
                "description": log.description,
                "created_at": log.created_at,
            }
            for log in logs
        ]

        return Response(data)