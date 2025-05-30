from django.shortcuts import render
from django.http import HttpResponse
# from django.contrib.auth.models import User, auth

# Create your views here.

class WitsNoteView:
    def index(self, request):
        return render(request, "index.html")

    def contact(self, request):
        return render(request, "contact.html")
    
    def topic_listing(self, request):
        return render(request, "topics-listing.html")

    def say_hello(self, request):
        return render(request, 'hello.html', {'name': 'Vince'})

    def add(self, request):
        if request.method == "POST":
            value1 = int(request.POST["num1"])
            value2 = int(request.POST["num2"])
            res = value1 + value2
            return render(request, "result.html", {"result": res})
        return render(request, "add.html")  # Render form initially

