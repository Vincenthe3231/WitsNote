from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from users.models import UserProfile
from django.contrib.auth.models import User

# Create your views here.
class UserProfileView:
    def user_profile(self, request):
        # profile = UserProfile.objects.get(user=request.user)
        profiles = UserProfile.objects.all()
        users = User.objects.get(id=2)
        return render(request, "user_profile.html", {'profiles': profiles, 'users': users})

    # @login_required
    def profile_setup(self, request):
        if request.method == "POST":
            first_name = request.POST.get("first_name")
            last_name = request.POST.get("last_name")
            profession = request.POST.get("profession")
            work_link = request.POST.get("work_link")
            skills = request.POST.get("skills")

            self.create_profile(request, first_name, last_name, profession, work_link, skills)
        return render(request, "profile_setup.html")

    def create_profile(self, first_name, last_name, profession, work_link, skills):
        # Save the user profile information
            user_profile = UserProfile.objects.create(
                # user=request.user,
                first_name=first_name,
                last_name=last_name,
                profession=profession,
                work_link=work_link,
                skills=skills
            )
            user_profile.save()
            return redirect("/")
        # return render(request, "profile_setup.html")