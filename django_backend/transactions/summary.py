from decimal import Decimal

# from django.db.models import Count
from django.db.models import Sum
from django.utils import timezone

from .models import Transaction


def get_daily_payment_summary():

    today = timezone.localdate()

    transactions = Transaction.objects.filter(
        created_at__date=today
    )

    total_count = transactions.count()

    success_count = transactions.filter(
        status="SUCCESS"
    ).count()

    failed_count = transactions.filter(
        status="FAILED"
    ).count()

    pending_count = transactions.filter(
        status="PENDING"
    ).count()

    total_amount = transactions.aggregate(
        total=Sum("amount")
    )["total"] or Decimal("0.00")

    success_amount = transactions.filter(
        status="SUCCESS"
    ).aggregate(
        total=Sum("amount")
    )["total"] or Decimal("0.00")

    return {
        "date": today,
        "total_count": total_count,
        "success_count": success_count,
        "failed_count": failed_count,
        "pending_count": pending_count,
        "total_amount": total_amount,
        "success_amount": success_amount,
    }