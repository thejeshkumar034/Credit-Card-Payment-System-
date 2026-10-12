import random
import uuid
from datetime import datetime

from fastapi import HTTPException
from sqlalchemy.orm import Session

from app.models.card import Card
from app.models.transaction import Transaction


def process_payment(
    db: Session,
    user_id: int,
    card_id: int,
    amount: float
):

    # Check that the card belongs to the logged-in user
    card = db.query(Card).filter(
        Card.id == card_id,
        Card.user_id == user_id
    ).first()

    if card is None:

        raise HTTPException(
            status_code=404,
            detail="Card not found."
        )

    transaction_id = str(
        uuid.uuid4()
    )

    transaction = Transaction(
        user_id=user_id,
        card_id=card_id,
        amount=amount,
        status="PENDING",
        transaction_id=transaction_id,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow()
    )

    db.add(transaction)

    db.commit()

    db.refresh(transaction)

    # Simulate payment processing
    payment_success = random.choice(
        [True, False]
    )

    if payment_success:

        transaction.status = "SUCCESS"

        message = "Payment successful."

    else:

        transaction.status = "FAILED"

        message = "Payment failed."

    transaction.updated_at = datetime.utcnow()

    db.commit()

    db.refresh(transaction)

    return transaction, message