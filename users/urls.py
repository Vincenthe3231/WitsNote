from django.urls import path
from .views import UserProfileView

UserProfileView = UserProfileView()

urlpatterns = [
    path('user-profile/', UserProfileView.user_profile, name='user_profile' ),
]