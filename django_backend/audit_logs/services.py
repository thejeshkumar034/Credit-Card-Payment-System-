from .models import AdminLog


def create_admin_log(
    admin_user,
    action,
    description
):
    return AdminLog.objects.create(
        admin_user=admin_user,
        action=action,
        description=description
    )