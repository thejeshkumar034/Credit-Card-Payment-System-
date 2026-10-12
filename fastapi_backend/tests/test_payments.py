from decimal import Decimal

import pytest
from fastapi import HTTPException
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import StaticPool

from app.database.connection import Base
from app.models.card import Card
from app.models.transaction import Transaction
from app.services.payment_service import process_payment


engine = create_engine(
    "sqlite://",
    connect_args={"check_same_thread": False},
    poolclass=StaticPool
)

TestingSessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)


@pytest.fixture
def db():
    Base.metadata.create_all(bind=engine)

    db = TestingSessionLocal()

    yield db

    db.close()

    Base.metadata.drop_all(bind=engine)


def create_test_card(db, user_id=1):
    card = Card(
        user_id=user_id,
        card_type="CREDIT",
        masked_card_number="************1111",
        last_four="1111",
        expiry_month=12,
        expiry_year=2030
    )

    db.add(card)
    db.commit()
    db.refresh(card)

    return card


def test_payment_success(db, monkeypatch):

    card = create_test_card(db, user_id=1)

    monkeypatch.setattr(
        "app.services.payment_service.random.choice",
        lambda values: True
    )

    transaction, message = process_payment(
        db=db,
        user_id=1,
        card_id=card.id,
        amount=Decimal("500.00")
    )

    assert transaction.status == "SUCCESS"
    assert transaction.amount == Decimal("500.00")
    assert message == "Payment successful."


def test_payment_failure(db, monkeypatch):

    card = create_test_card(db, user_id=1)

    monkeypatch.setattr(
        "app.services.payment_service.random.choice",
        lambda values: False
    )

    transaction, message = process_payment(
        db=db,
        user_id=1,
        card_id=card.id,
        amount=Decimal("500.00")
    )

    assert transaction.status == "FAILED"
    assert transaction.amount == Decimal("500.00")
    assert message == "Payment failed."


def test_payment_card_ownership(db):

    card = create_test_card(db, user_id=1)

    with pytest.raises(HTTPException) as error:

        process_payment(
            db=db,
            user_id=999,
            card_id=card.id,
            amount=Decimal("500.00")
        )

    assert error.value.status_code == 404
    assert error.value.detail == "Card not found."