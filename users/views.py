from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.shortcuts import render, redirect
from users.models import UserProfile, PostCollection
from cryptography.fernet import Fernet
from django.conf import settings
# from django.contrib.auth.models import User

# Create your views here.
class UserProfileView:
    
    def __init__(self):
        self.__key = settings.ENCRYPTION_KEY
        self.__cipher = Fernet(self.__key)
        
    def user_profile(self, request):
        profiles = UserProfile.objects.get(user=request.user)
        users = request.user

        # Decrypt phone number
        phone_decryption = self.__cipher.decrypt(profiles.phone).decode()

        # Get user's saved posts from PostCollection
        try:
            collection = PostCollection.objects.get(user=request.user)
            collected_posts = collection.posts.all()
        except PostCollection.DoesNotExist:
            collected_posts = []

        return render(request, "user_profile.html", {
            'profiles': profiles,
            'users': users,
            'phone_decryption': phone_decryption,
            'collected_posts': collected_posts
        })

    @method_decorator(login_required, name='profile_setup')
    def profile_setup(self, request):
        if request.method == "POST":
            phone = request.POST.get("phone")
            profession = request.POST.get("profession")
            work_link = request.POST.get("work_link")
            skills = request.POST.get("skills")

            phone_encryption = self.__cipher.encrypt(phone.encode()).decode()

            return self.create_profile(request, phone_encryption, profession, work_link, skills)
        return render(request, "profile_setup.html")

    def create_profile(self, request, phone, profession, work_link, skills):
        # Save the user profile information
        user_profile = UserProfile.objects.create(
            user=request.user,
            phone=phone,
            profession=profession,
            work_link=work_link,
            skills=skills
        )
        user_profile.save()
        return redirect("home")