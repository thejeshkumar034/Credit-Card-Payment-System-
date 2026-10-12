from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class UserAuthenticationTests(APITestCase):

    def test_user_registration(self):
        data = {
            "username": "testuser",
            "email": "testuser@example.com",
            "password": "StrongPassword@123",
            "password2": "StrongPassword@123"
        }

        response = self.client.post(
            "/api/auth/register/",
            data,
            format="json"
        )

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertTrue(
            User.objects.filter(username="testuser").exists()
        )

    def test_password_is_hashed(self):
        user = User.objects.create_user(
            username="hashuser",
            email="hash@example.com",
            password="StrongPassword@123"
        )

        self.assertNotEqual(
            user.password,
            "StrongPassword@123"
        )

        self.assertTrue(
            user.check_password("StrongPassword@123")
        )

    def test_duplicate_username(self):
        User.objects.create_user(
            username="duplicate",
            email="first@example.com",
            password="StrongPassword@123"
        )

        data = {
            "username": "duplicate",
            "email": "second@example.com",
            "password": "StrongPassword@123",
            "password2": "StrongPassword@123"
        }

        response = self.client.post(
            "/api/auth/register/",
            data,
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_400_BAD_REQUEST
        )

    def test_login_returns_jwt_tokens(self):
        User.objects.create_user(
            username="loginuser",
            email="login@example.com",
            password="StrongPassword@123"
        )

        data = {
            "username": "loginuser",
            "password": "StrongPassword@123"
        }

        response = self.client.post(
            "/api/auth/login/",
            data,
            format="json"
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn("access", response.data)
        self.assertIn("refresh", response.data)

    def test_profile_requires_authentication(self):
        response = self.client.get(
            "/api/auth/profile/"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_401_UNAUTHORIZED
        )

    def test_authenticated_profile(self):
        user = User.objects.create_user(
            username="profileuser",
            email="profile@example.com",
            password="StrongPassword@123"
        )

        self.client.force_authenticate(user=user)

        response = self.client.get(
            "/api/auth/profile/"
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(
            response.data["username"],
            "profileuser"
        )

    def test_logout(self):
        User.objects.create_user(
            username="logoutuser",
            email="logout@example.com",
            password="StrongPassword@123"
        )

        login_response = self.client.post(
            "/api/auth/login/",
            {
                "username": "logoutuser",
                "password": "StrongPassword@123"
            },
            format="json"
        )

        refresh_token = login_response.data["refresh"]

        access_token = login_response.data["access"]

        self.client.credentials(
            HTTP_AUTHORIZATION=f"Bearer {access_token}"
        )

        response = self.client.post(
            "/api/auth/logout/",
            {
                "refresh": refresh_token
            },
            format="json"
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_205_RESET_CONTENT
        )