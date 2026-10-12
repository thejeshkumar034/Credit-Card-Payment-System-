from django.contrib.admin.views.decorators import staff_member_required
from django.http import JsonResponse

from .summary import get_daily_payment_summary


@staff_member_required
def daily_payment_summary(request):

    summary = get_daily_payment_summary()

    return JsonResponse({
        "date": str(summary["date"]),
        "total_transactions": summary["total_count"],
        "successful_transactions": summary["success_count"],
        "failed_transactions": summary["failed_count"],
        "pending_transactions": summary["pending_count"],
        "total_amount": str(
            summary["total_amount"]
        ),
        "successful_amount": str(
            summary["success_amount"]
        ),
    })