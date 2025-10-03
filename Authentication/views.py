from django.http import JsonResponse
from django.shortcuts import redirect, render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.contrib import messages
from django.views import View
from users.models import UserProfile

class LoginView(View):
    template_name = "login.html"

    def get(self, request):
        return render(request, self.template_name)

    def post(self, request):
        username = request.POST.get("username", "").strip()
        password = request.POST.get("password", "")

        user = authenticate(request, username=username, password=password)
        if user is not None:
            auth_login(request, user)
            messages.success(request, f"Welcome, {user.first_name}!")

            if not UserProfile.objects.filter(user=user).exists():
                return redirect("profile_setup")
            return redirect("home")

        return render(request, self.template_name, {"error": "Invalid credentials."})
    
class LogoutView(View):
    def get(self, request):
        auth_logout(request)
        return redirect("home")

class RegisterView(View):
    template_name = "signup.html"

    def get(self, request):
        return render(request, self.template_name)

    def post(self, request):
        first_name = request.POST.get("first_name", "").strip()
        last_name = request.POST.get("last_name", "").strip()
        username = request.POST.get("username", "").strip()
        email = request.POST.get("email", "").strip()
        password = request.POST.get("password", "")
        confirm_password = request.POST.get("confirm_password", "")

        # Validation
        if not username or not email or not password or not confirm_password:
            return render(request, self.template_name, {"error": "All fields are required."})

        if password != confirm_password:
            return render(request, self.template_name, {"error": "Passwords do not match."})

        if User.objects.filter(username=username).exists():
            return render(request, self.template_name, {"error": "Username already exists."})

        if User.objects.filter(email=email).exists():
            return render(request, self.template_name, {"error": "Email already exists."})

        # Create user
        User.objects.create_user(
            username=username,
            email=email,
            password=password,
            first_name=first_name,
            last_name=last_name,
            is_superuser=False,
            is_staff=False,
            is_active=True,
        )

        messages.success(request, "Account created successfully. Please log in.")
        return redirect("login")

class CheckUsernameView(View):
    def get(self, request):
        username = request.GET.get("username", "").strip()
        exists = User.objects.filter(username=username).exists()
        return JsonResponse({"exists": exists})

class CheckEmailView(View):
    def get(self, request):
        email = request.GET.get("email", "").strip()
        exists = User.objects.filter(email=email).exists()
        return JsonResponse({"exists": exists})
