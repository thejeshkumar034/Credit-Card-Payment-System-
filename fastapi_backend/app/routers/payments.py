from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.core.security import get_current_user_id
from app.database.connection import get_db
from app.schemas.payment import (
    PaymentRequest,
    PaymentResponse
)
from app.services.payment_service import (
    process_payment
)


router = APIRouter(
    prefix="/api/payments",
    tags=["Payments"]
)


@router.post(
    "/",
    response_model=PaymentResponse
)
def make_payment(
    payment: PaymentRequest,
    user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db)
):

    transaction, message = process_payment(
        db=db,
        user_id=user_id,
        card_id=payment.card_id,
        amount=payment.amount
    )

    return PaymentResponse(
        transaction_id=transaction.transaction_id,
        user_id=transaction.user_id,
        card_id=transaction.card_id,
        amount=transaction.amount,
        status=transaction.status,
        message=message
    )