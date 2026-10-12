# Credit Card Payment System

A full-stack backend application for managing users, saved credit/debit cards, payments, transactions, and administrative operations.

The project uses **Django REST Framework** for authentication, card management, transaction management, and administration, while **FastAPI** handles payment processing.

---

## 1. Project Overview

The Credit Card Payment System provides a secure backend workflow for:

* User registration and login
* JWT authentication
* Protected API endpoints
* Credit/debit card management
* Secure card masking
* Payment processing
* Payment success/failure simulation
* Transaction history
* Transaction filtering
* Django admin management
* CSV transaction export
* Daily payment summary
* Admin activity logging
* API documentation
* Automated testing
* Code coverage

---

## 2. Technologies Used

| Technology            | Purpose                              |
| --------------------- | ------------------------------------ |
| Python                | Backend programming language         |
| Django                | Main backend framework               |
| Django REST Framework | REST APIs                            |
| Simple JWT            | JWT authentication                   |
| FastAPI               | Payment processing service           |
| SQLAlchemy            | FastAPI database access              |
| MySQL                 | Application database                 |
| PyMySQL               | MySQL database driver                |
| Pydantic              | FastAPI request validation           |
| django-filter         | Transaction filtering                |
| drf-spectacular       | Django OpenAPI/Swagger documentation |
| Pytest                | Automated testing                    |
| pytest-cov            | Code coverage                        |
| Postman               | API testing                          |
| Git/GitHub            | Version control                      |

---

## 3. Architecture

```text
                         Client
                           |
             +-------------+-------------+
             |                           |
             v                           v
       Django REST API              FastAPI API
          Port 8000                  Port 8001
             |                           |
             |                           |
      Authentication              Payment Processing
      Card Management                    |
      Transactions                       |
      Admin Panel                        |
             |                           |
             +-------------+-------------+
                           |
                           v
                         MySQL
                credit_card_payment_system
```

### Django responsibilities

* User registration
* JWT login/logout
* User profile
* Card management
* Transaction history
* Transaction filtering
* Django admin
* CSV export
* Daily payment summary
* Admin logs

### FastAPI responsibilities

* JWT validation
* Payment request validation
* Card ownership validation
* Payment processing
* PENDING status creation
* SUCCESS/FAILED simulation
* Transaction update

---

## 4. Project Structure

```text
CreditCardPaymentSystem/
│
├── django_backend/
│   ├── manage.py
│   ├── requirements.txt
│   ├── .env
│   ├── .env.example
│   ├── pytest.ini
│   │
│   ├── config/
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── asgi.py
│   │   └── wsgi.py
│   │
│   ├── users/
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── admin.py
│   │   └── tests.py
│   │
│   ├── cards/
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── admin.py
│   │   └── tests.py
│   │
│   ├── transactions/
│   │   ├── models.py
│   │   ├── serializers.py
│   │   ├── filters.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── admin.py
│   │   ├── summary.py
│   │   ├── summary_views.py
│   │   └── tests.py
│   │
│   ├── audit_logs/
│   │   ├── models.py
│   │   ├── services.py
│   │   └── admin.py
│   │
│   └── exports/
│
├── fastapi_backend/
│   ├── requirements.txt
│   ├── .env
│   │
│   ├── app/
│   │   ├── main.py
│   │   │
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   └── security.py
│   │   │
│   │   ├── database/
│   │   │   └── connection.py
│   │   │
│   │   ├── models/
│   │   │   ├── card.py
│   │   │   └── transaction.py
│   │   │
│   │   ├── schemas/
│   │   │   └── payment.py
│   │   │
│   │   ├── routers/
│   │   │   └── payments.py
│   │   │
│   │   └── services/
│   │       └── payment_service.py
│   │
│   └── tests/
│       └── test_payments.py
│
├── postman/
│   └── CreditCardPaymentSystem.postman_collection.json
│
├── screenshots/
│
├── database/
│
├── docs/
│
└── README.md
```

---

## 5. Database

Create the MySQL database:

```sql
CREATE DATABASE credit_card_payment_system
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
```

The main application tables are created through Django migrations.

Important tables include:

* `auth_user`
* `cards_card`
* `transactions_transaction`
* `audit_logs_adminlog`

---

## 6. Environment Configuration

Create:

```text
django_backend/.env
```

Example:

```env
SECRET_KEY=your-django-secret-key
DEBUG=True

DB_NAME=credit_card_payment_system
DB_USER=root
DB_PASSWORD=your-mysql-password
DB_HOST=127.0.0.1
DB_PORT=3306
```

FastAPI:

```text
fastapi_backend/.env
```

Example:

```env
DATABASE_URL=mysql+pymysql://root:your-mysql-password@127.0.0.1:3306/credit_card_payment_system
JWT_SECRET_KEY=your-jwt-secret-key
JWT_ALGORITHM=HS256
```

Never commit the actual `.env` files to GitHub.

---

# 7. Django Setup

Navigate to:

```powershell
cd C:\FastAPI_Tasks\CreditCardPaymentSystem\django_backend
```

Create/activate the virtual environment:

```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

Install dependencies:

```powershell
pip install -r requirements.txt
```

Run migrations:

```powershell
python manage.py makemigrations
python manage.py migrate
```

Create an admin user:

```powershell
python manage.py createsuperuser
```

Run Django:

```powershell
python manage.py runserver
```

Django will run at:

```text
http://127.0.0.1:8000/
```

---

# 8. FastAPI Setup

Open another terminal:

```powershell
cd C:\FastAPI_Tasks\CreditCardPaymentSystem\fastapi_backend
```

Create/activate the virtual environment:

```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

Install dependencies:

```powershell
pip install -r requirements.txt
```

Run FastAPI:

```powershell
uvicorn app.main:app --reload --port 8001
```

FastAPI will run at:

```text
http://127.0.0.1:8001/
```

The `--reload` option is intended for development and should not be used as a production server configuration.

---

# 9. Authentication APIs

## Register

```http
POST /api/auth/register/
```

Request:

```json
{
    "username": "john",
    "email": "john@example.com",
    "password": "StrongPassword@123",
    "password2": "StrongPassword@123"
}
```

---

## Login

```http
POST /api/auth/login/
```

Request:

```json
{
    "username": "john",
    "password": "StrongPassword@123"
}
```

Response contains:

```json
{
    "refresh": "JWT_REFRESH_TOKEN",
    "access": "JWT_ACCESS_TOKEN"
}
```

---

## Profile

```http
GET /api/auth/profile/
```

Authentication:

```text
Authorization: Bearer <access_token>
```

---

## Refresh Token

```http
POST /api/auth/token/refresh/
```

---

## Logout

```http
POST /api/auth/logout/
```

Request:

```json
{
    "refresh": "JWT_REFRESH_TOKEN"
}
```

---

# 10. Card Management APIs

## Add Card

```http
POST /api/cards/
```

Example:

```json
{
    "card_type": "CREDIT",
    "card_number": "4111111111111111",
    "expiry_month": 12,
    "expiry_year": 2030
}
```

The complete card number is accepted temporarily for validation but is never stored in the database.

Stored information:

```text
************1111
last_four = 1111
```

CVV is not accepted or stored.

---

## View Cards

```http
GET /api/cards/
```

---

## View Card

```http
GET /api/cards/{id}/
```

---

## Delete Card

```http
DELETE /api/cards/{id}/
```

Users can access only their own cards.

---

# 11. Payment API

Payment processing is handled by FastAPI.

```http
POST http://127.0.0.1:8001/api/payments/
```

Authorization:

```text
Bearer <Django access token>
```

Request:

```json
{
    "card_id": 1,
    "amount": 500.00
}
```

The user ID is obtained from the JWT rather than being accepted from the request body.

Payment flow:

```text
Request
   |
   v
Validate JWT
   |
   v
Validate Card Ownership
   |
   v
Create Transaction
   |
   v
PENDING
   |
   v
Payment Simulation
   |
   +----------+
   |          |
   v          v
SUCCESS     FAILED
```

---

# 12. Transaction APIs

## Transaction History

```http
GET /api/transactions/
```

---

## Filter by Status

```http
GET /api/transactions/?status=SUCCESS
```

---

## Filter by Amount

```http
GET /api/transactions/?min_amount=500&max_amount=5000
```

---

## Filter by Date

```http
GET /api/transactions/?date_from=2026-10-01&date_to=2026-10-08
```

---

## Transaction Detail

```http
GET /api/transactions/{id}/
```

Users can view only their own transactions.

---

# 13. Admin Panel

Django admin:

```text
http://127.0.0.1:8000/admin/
```

The admin can manage:

* Users
* Cards
* Transactions
* Admin logs

Transaction CSV export is available through the Django transaction admin action.

---

# 14. Daily Payment Summary

Admin-only endpoint:

```text
http://127.0.0.1:8000/admin/daily-summary/
```

The summary provides:

* Total transactions
* Successful transactions
* Failed transactions
* Pending transactions
* Total amount
* Successful amount

---

# 15. API Documentation

## Django Swagger

```text
http://127.0.0.1:8000/api/docs/
```

## Django OpenAPI Schema

```text
http://127.0.0.1:8000/api/schema/
```

## Django ReDoc

```text
http://127.0.0.1:8000/api/redoc/
```

## FastAPI Swagger

```text
http://127.0.0.1:8001/docs
```

## FastAPI ReDoc

```text
http://127.0.0.1:8001/redoc
```

---

# 16. Postman

The Postman collection is located at:

```text
postman/CreditCardPaymentSystem.postman_collection.json
```

Import it into Postman.

Recommended workflow:

```text
Register
   ↓
Login
   ↓
Store JWT
   ↓
Add Card
   ↓
Make Payment
   ↓
View Transactions
```

---

# 17. Testing

Django tests:

```powershell
cd django_backend
pytest
```

Coverage:

```powershell
pytest --cov=users --cov=cards --cov=transactions --cov=audit_logs --cov-report=term-missing
```

Minimum required coverage:

```text
50%
```

Current project coverage:

```text
91.45%
```

Latest test result:

```text
17 passed
91.45% coverage
```

FastAPI tests:

```powershell
cd fastapi_backend
pytest
```

FastAPI coverage:

```powershell
pytest --cov=app --cov-report=term-missing
```

---

# 18. Security

The application implements:

* JWT authentication
* Password hashing through Django authentication
* Protected API endpoints
* Card ownership validation
* Input validation
* Luhn card-number validation
* Card number masking
* No full card-number storage
* No CVV storage
* SQLAlchemy ORM
* Django ORM
* Environment-based secrets
* Admin access control

For production deployment, HTTPS should be used for APIs that handle authentication or other sensitive data, and production secrets should remain outside source control.

---

# 19. Sensitive Card Data

The system does not store:

```text
Full card number
CVV
```

It stores:

```text
Masked card number
Last four digits
Card type
Expiry month
Expiry year
```

Example:

```text
************1111
```

---

# 20. Testing Coverage

The project includes tests for:

* User registration
* Duplicate username
* Password hashing
* JWT login
* Protected profile
* Logout
* Card creation
* Card masking
* Card ownership
* Card deletion
* Transaction history
* Transaction filtering
* Transaction ownership
* Payment success
* Payment failure
* Invalid card ownership

Current result:

```text
17 tests passed
91.45% coverage
```

---

# 21. Screenshots

The `screenshots/` directory contains screenshots demonstrating:

* Django admin
* Django Swagger
* FastAPI Swagger
* Postman APIs
* Users
* Cards
* Transactions
* Admin logs

---

# 22. Database Dump

The database dump should be stored under:

```text
database/
```

Example:

```text
database/credit_card_payment_system.sql
```

The dump should contain the database schema and, if required for submission, appropriate sample data.

Do not include real passwords, production credentials, or sensitive card information.

---

# 23. Git

Initialize Git from the project root:

```powershell
cd C:\FastAPI_Tasks\CreditCardPaymentSystem
git init
```

Check files:

```powershell
git status
```

Add files:

```powershell
git add .
```

Create the initial commit:

```powershell
git commit -m "Complete credit card payment system backend"
```

---

# 24. Final Verification

Before submission, verify:

```text
[ ] MySQL database created
[ ] Django migrations completed
[ ] Django server starts
[ ] FastAPI server starts
[ ] Registration works
[ ] Login works
[ ] JWT authentication works
[ ] Logout works
[ ] Card creation works
[ ] Card masking works
[ ] CVV is not stored
[ ] Full card number is not stored
[ ] Payment API works
[ ] Payment returns SUCCESS/FAILED
[ ] Transactions are created
[ ] Transaction filters work
[ ] Admin panel works
[ ] CSV export works
[ ] Daily summary works
[ ] Admin logs work
[ ] Django Swagger works
[ ] FastAPI Swagger works
[ ] Postman collection imported
[ ] Tests pass
[ ] Coverage is above 50%
[ ] README completed
[ ] Database dump created
[ ] Screenshots added
[ ] .env excluded from Git
[ ] Git repository created
```

---

## 25. Author

**Project:** Credit Card Payment System

**Type:** Full Stack Junior Application Task

**Backend:** Django + Django REST Framework + FastAPI

**Database:** MySQL

**Authentication:** JWT

**Testing:** Pytest

**API Testing:** Postman

**Documentation:** Swagger / OpenAPI / README

---
#   C r e d i t - C a r d - P a y m e n t - S y s t e m -  
 