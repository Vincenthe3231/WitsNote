from django.shortcuts import render
from users.models import UserProfile
from django.contrib.auth.models import User

# Create your views here.
class UserProfileView:
    def user_profile(self, request):
        users = User.objects.all()
        return render(request, "user_profile.html", {'users': users})