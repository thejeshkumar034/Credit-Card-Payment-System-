from django.contrib import admin

from .models import AdminLog


@admin.register(AdminLog)
class AdminLogAdmin(admin.ModelAdmin):

    list_display = (
        "id",
        "admin_user",
        "action",
        "description",
        "created_at",
    )

    list_filter = (
        "action",
        "created_at",
    )

    search_fields = (
        "admin_user__username",
        "description",
    )

    readonly_fields = (
        "admin_user",
        "action",
        "description",
        "created_at",
    )