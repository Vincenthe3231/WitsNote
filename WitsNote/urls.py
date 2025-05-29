from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='home'),
    path('contact/', views.contact, name='contact'),
    path('user-profile/', views.user_profile, name='user_profile' ),
    path('hello/', views.say_hello),
    path('add/', views.add),
    
]