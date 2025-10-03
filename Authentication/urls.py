from django.urls import path
from .views import LoginView, LogoutView, RegisterView, CheckUsernameView, CheckEmailView

urlpatterns = [
    path("login/", LoginView.as_view(), name="login"),
    path("logout/", LogoutView.as_view(), name="logout"),
    path("register/", RegisterView.as_view(), name="register"),
    path("check-username/", CheckUsernameView.as_view(), name="check_username"),
    path("check-email/", CheckEmailView.as_view(), name="check_email"),
]
