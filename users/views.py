from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET, require_POST
from django.utils.decorators import method_decorator
from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from users.models import UserProfile, PostCollection
from cryptography.fernet import Fernet
from django.conf import settings
from django import template
import json
import uuid
# from django.contrib.auth.models import User

# Create your views here.
class UserProfileView:
    
    def __init__(self):
        self.__key = settings.ENCRYPTION_KEY
        self.__cipher = Fernet(self.__key)
        self._decorators = [csrf_exempt, require_POST]

    @method_decorator(require_GET, name='user_profile')
    def user_profile(self, request):
        try:
            profiles = UserProfile.objects.get(user=request.user)
        except UserProfile.DoesNotExist:
            # No profile yet → go straight to setup page
            return redirect("profile_setup")

        users = request.user

        # Check for empty required fields
        required_fields = [profiles.phone, profiles.profession, profiles.work_link, profiles.skills]
        if any(not field for field in required_fields):
            return redirect("profile_setup")
            # return render(request, "profile_setup.html")

        # Decrypt phone number
        phone_decryption = self.__cipher.decrypt(profiles.phone).decode()

        # Get user's saved posts from PostCollection
        try:
            collection = PostCollection.objects.get(user=request.user)
            collected_posts = collection.posts.all()
        except PostCollection.DoesNotExist:
            collected_posts = []

        profile_picture = profiles.profile_picture.url if profiles.profile_picture else None
        try:
            work_links = json.loads(profiles.work_link or "[]")
        except json.JSONDecodeError:
            work_links = []
        skills = profiles.skills.split("\n") if profiles.skills else []  # Split by newline for skills

        return render(request, "user_profile.html", {
            'profiles': profiles,
            'users': users,
            'phone_decryption': phone_decryption,
            'collected_posts': collected_posts,
            'work_links': work_links,
            'skills': skills,
            'profile_picture': profile_picture
    })


    @method_decorator(login_required, name='profile_setup')
    def profile_setup(self, request):
        if request.method == "POST":
            phone = request.POST.get("phone")
            profession = request.POST.get("profession")
            work_link = request.POST.get("work_link")
            skills = request.POST.get("skills")

            phone_encryption = self.__cipher.encrypt(phone.encode()).decode()

            # Handle work_link properly
            if work_link:
                if not work_link.startswith(("http://", "https://")):
                    work_link = f"http://{work_link}"
            else:
                work_link = "[]"  # empty JSON array as default

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

    @method_decorator([csrf_exempt, require_POST], name='add_skill')
    def add_skill(self, request):
        data = json.loads(request.body)
        skill = data.get("skill")
        if skill:
            profiles = UserProfile.objects.get(user=request.user)
            if profiles.skills:
                profiles.skills += f"\n{skill}"
            else:
                profiles.skills = f"{skill}"
            profiles.save()
            return JsonResponse({"success": True})
        return JsonResponse({"success": False})

    @method_decorator([csrf_exempt, require_POST, login_required], name='add_work_link')
    def add_work_link(self, request):
        data = json.loads(request.body)
        title = data.get("title")
        url = data.get("url")

        if not title or not url:
            return JsonResponse({"success": False, "error": "Title and URL required."})

        try:
            profile = UserProfile.objects.get(user=request.user)
            work_links = json.loads(profile.work_link or "[]")

            new_link = {
                "id": str(uuid.uuid4()),  # unique ID
                "title": title,
                "url": url
            }

            work_links.append(new_link)
            profile.work_link = json.dumps(work_links)
            profile.save()

            return JsonResponse({"success": True, "link": new_link})
        except UserProfile.DoesNotExist:
            return JsonResponse({"success": False, "error": "User profile not found."})


    @method_decorator([csrf_exempt, require_POST, login_required], name='delete_skill')
    def remove_skill(self, request):
        """
        Deletes a skill from the user's profile via an AJAX request.
        """
        data = json.loads(request.body)
        skill_to_delete = data.get("skill")
        
        if skill_to_delete:
            try:
                profiles = UserProfile.objects.get(user=request.user)
                
                # Split the existing skills string into a list
                skills_list = profiles.skills.split("\n") if profiles.skills else []
                
                # Filter out the skill to be deleted
                updated_skills_list = [s for s in skills_list if s != skill_to_delete]
                
                # Join the remaining skills back into a string, separated by newlines
                if updated_skills_list:
                    profiles.skills = "\n".join(updated_skills_list)
                else:
                    profiles.skills = ""  # or profiles.skills = None if you want to store it as null
                profiles.save()
                
                return JsonResponse({"success": True})
            except UserProfile.DoesNotExist:
                return JsonResponse({"success": False, "error": "User profile not found."})
        
        return JsonResponse({"success": False, "error": "No skill provided."})
    
    @method_decorator([csrf_exempt, require_POST, login_required], name='remove_work_link')
    def remove_work_link(self, request):
        data = json.loads(request.body)
        link_id = data.get("id")

        if not link_id:
            return JsonResponse({"success": False, "error": "No link ID provided."})

        try:
            profile = UserProfile.objects.get(user=request.user)
            work_links = json.loads(profile.work_link or "[]")

            updated = [link for link in work_links if link["id"] != link_id]

            if len(updated) == len(work_links):
                return JsonResponse({"success": False, "error": "Link not found."})

            # If no links remain, store an empty string instead of "[]"
            profile.work_link = json.dumps(updated) if updated else ""
            profile.save()

            return JsonResponse({"success": True})
        except UserProfile.DoesNotExist:
            return JsonResponse({"success": False, "error": "User profile not found."})

    
    @method_decorator([csrf_exempt, require_POST, login_required], name='update_profile')
    def update_profile(self, request):
        """
        Updates core user profile information (phone, profession) via an AJAX request.
        """
        data = json.loads(request.body)
        phone = data.get("phone")
        profession = data.get("profession")
        
        try:
            profiles = UserProfile.objects.get(user=request.user)
            
            if phone:
                # Re-encrypt the new phone number
                profiles.phone = self.__cipher.encrypt(phone.encode()).decode()
            if profession:
                profiles.profession = profession
            
            profiles.save()
            
            return JsonResponse({"success": True})
        except UserProfile.DoesNotExist:
            return JsonResponse({"success": False, "error": "User profile not found."})    
        
    @method_decorator(login_required)
    @method_decorator(csrf_exempt)
    @method_decorator(require_POST)
    def upload_profile_pic(self, request):
        if request.method == "POST":
            profile = UserProfile.objects.get(user=request.user)

            if "profile_picture" in request.FILES:
                profile.profile_picture = request.FILES["profile_picture"]
                profile.save()
                return JsonResponse({"success": True, "image_url": profile.profile_picture.url})
            
            return JsonResponse({"success": False, "error": "No file uploaded."})

        return JsonResponse({"success": False, "error": "Invalid request."})
