from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String

from app.database.connection import Base


class Card(Base):

    __tablename__ = "cards_card"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    user_id = Column(
        Integer,
        nullable=False,
        index=True
    )

    card_type = Column(
        String(10),
        nullable=False
    )

    masked_card_number = Column(
        String(19),
        nullable=False
    )

    last_four = Column(
        String(4),
        nullable=False
    )

    expiry_month = Column(
        Integer,
        nullable=False
    )

    expiry_year = Column(
        Integer,
        nullable=False
    )