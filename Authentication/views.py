from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login as auth_login, logout
from django.contrib import messages
from users.models import UserProfile

# Create your views here.
class Authentication:
    
    def login(self, request):
        # Handle user login and login page render
        if request.method == "POST":
            username = request.POST.get("username", "").strip()
            password = request.POST.get("password", "")

            user = authenticate(request, username=username, password=password)
            if user is not None:
                auth_login(request, user)
                messages.success(request, f"Welcome, {user.first_name}!")
                if not UserProfile.objects.filter(user=user).exists():
                    return redirect("profile_setup")
                else:
                    return redirect("home")
            else:
                return render(request, "login.html", {"error": "Invalid credentials."})

        return render(request, "login.html")

    def logout(self, request):
        # Logout and terminate the session
        logout(request)
        return redirect("home")

    def register(self, request):
        if request.method == "POST":
            # Get form data
            first_name = request.POST.get("first_name", "").strip()
            last_name = request.POST.get("last_name", "").strip()
            username = request.POST.get("username", "").strip()
            email = request.POST.get("email", "").strip()
            password = request.POST.get("password", "")

            # Basic validation (optional but recommended)
            if not username or not email or not password:
                return render(request, "register.html", {"error": "All fields are required."})
            
            elif User.objects.filter(username=username).exists():
                return render(request, "register.html", {"error": "Username already exists."})
            
            elif User.objects.filter(email=email).exists():
                return render(request, "register.html", {"error": "Email already exists."})

            return self.create_user(request, first_name, last_name, username, email, password)

        return render(request, "signup.html")  # For GET request

    def create_user(self, request, first_name, last_name, username, email, password):
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password,
            is_superuser=False,
            is_staff=False,
            is_active=True,
            first_name=first_name,
            last_name=last_name
        )
        user.save()

        return render(request, "login.html")  # You might want to redirect instead
