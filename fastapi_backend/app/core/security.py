from fastapi import Depends, HTTPException, status

from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer 

from jose import JWTError, jwt

from app.core.config import JWT_ALGORITHM, JWT_SECRET_KEY


from app.core.config import (
    JWT_ALGORITHM,
    JWT_SECRET_KEY
)


security = HTTPBearer(
    scheme_name="BearerAuth",
    bearerFormat="JWT",
)


def get_current_user_id(
    credentials: HTTPAuthorizationCredentials = Depends(security)
):

    token = credentials.credentials

    try:

        payload = jwt.decode(
            token,
            JWT_SECRET_KEY,
            algorithms=[JWT_ALGORITHM]
        )

        user_id = payload.get("user_id")

        if user_id is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid token."
            )

        return int(user_id)

    except (JWTError, ValueError, TypeError):

        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired token."
        )