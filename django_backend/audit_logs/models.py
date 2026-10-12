from django.contrib.auth.models import User
from django.db import models


class AdminLog(models.Model):

    ACTION_CHOICES = [
        ("LOGIN", "Admin Login"),
        ("EXPORT", "Export"),
        ("VIEW", "View"),
        ("CREATE", "Create"),
        ("UPDATE", "Update"),
        ("DELETE", "Delete"),
    ]

    admin_user = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="admin_logs"
    )

    action = models.CharField(
        max_length=20,
        choices=ACTION_CHOICES
    )

    description = models.TextField()

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    def __str__(self):
        return (
            f"{self.admin_user} - "
            f"{self.action} - "
            f"{self.created_at}"
        )