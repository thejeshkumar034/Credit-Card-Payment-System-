import csv

from django.contrib import admin
from django.http import HttpResponse

from .models import Transaction
from audit_logs.services import create_admin_log


@admin.action(description="Export selected transactions to CSV")
def export_transactions_to_csv(
    modeladmin,
    request,
    queryset
):

    response = HttpResponse(
        content_type="text/csv"
    )

    response["Content-Disposition"] = (
        'attachment; filename="transactions.csv"'
    )

    writer = csv.writer(response)

    writer.writerow([
        "Transaction ID",
        "Username",
        "Email",
        "Card",
        "Amount",
        "Status",
        "Created At",
        "Updated At",
    ])

    for transaction in queryset.select_related(
        "user",
        "card"
    ):

        writer.writerow([
            transaction.transaction_id,
            transaction.user.username,
            transaction.user.email,
            transaction.card.masked_card_number,
            transaction.amount,
            transaction.status,
            transaction.created_at,
            transaction.updated_at,
        ])
        
    create_admin_log(
        admin_user=request.user,
        action="EXPORT",
        description=(
            f"Exported {queryset.count()} "
            f"transaction(s) to CSV."
        )
    )

    return response


@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):

    list_display = (
        "id",
        "transaction_id",
        "user",
        "card",
        "amount",
        "status",
        "created_at",
        "updated_at",
    )

    list_filter = (
        "status",
        "created_at",
    )

    search_fields = (
        "transaction_id",
        "user__username",
        "user__email",
        "card__last_four",
    )

    readonly_fields = (
        "transaction_id",
        "user",
        "card",
        "amount",
        "status",
        "created_at",
        "updated_at",
    )

    actions = [
        export_transactions_to_csv
    ]