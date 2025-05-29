from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.models import User, auth

# Create your views here.

def index(request):
    return render(request, "index.html")

def contact(request):
    return render(request, "contact.html")

def user_profile(request):
    users = User.objects.all()
    return render(request, "user-profile.html", {'users': users})

def say_hello(request):
    return render(request, 'hello.html', {'name': 'Vince'})

def add(request):
    if request.method == "POST":
        value1 = int(request.POST["num1"])
        value2 = int(request.POST["num2"])
        res = value1 + value2
        return render(request, "result.html", {"result": res})
    return render(request, "add.html")  # Render form initially

