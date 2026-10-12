from django.urls import path

from .views import (
    AdminSummaryView,
    AdminTransactionExportView,
    AdminLogsView,
)

urlpatterns = [
    path("summary/", AdminSummaryView.as_view(), name="admin-summary"),
    path(
        "transactions/export/",
        AdminTransactionExportView.as_view(),
        name="admin-transaction-export",
    ),
    path("logs/", AdminLogsView.as_view(), name="admin-logs"),
]
