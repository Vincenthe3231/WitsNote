from django.urls import path
from .views import Authentication

auth = Authentication()

urlpatterns = [
    path('login/', auth.login, name='login'),
    path('logout/', auth.logout, name='logout'),
    path('register/', auth.register, name='register'),
]
