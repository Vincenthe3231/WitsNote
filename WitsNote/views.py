from django.shortcuts import render
from .models import Post
from django.http import HttpResponse
from django.conf import settings
from WitsNote.template.handlers.standard_blog_post import StandardBlogPostHandler
# from django.contrib.auth.models import User, auth

# Create your views here.

class WitsNoteView:
    def index(self, request):
        posts = Post.objects.all().order_by('-created_at')
        return render(request, "index.html", {'posts': posts})

    # def post_listing(self, request):
    #     posts = Post.objects.all().order_by('-created_at')
    #     return render(request, 'post-list.html', {'posts': posts})

    def contact(self, request):
        return render(request, "contact.html")
    
    def topic_listing(self, request):
        return render(request, "topics-listing.html")
    
    def create_post(self, request):
        return render(request, "create-post-home.html")

    def post_detail(self, request, post_id):
        post = Post.objects.get(id=post_id)
        return render(request, "post-detail.html", {'post': post})

    def create_standard_blog_post(self, request):
        context = {
            'gemini_api_key': settings.GEMINI_API_KEY,
            'gemini_api_url': settings.GEMINI_API_URL,
            'author': request.user.username
        }
        
        if request.method == "POST":
            return self.post_dispatcher(request, "standard_blog_post")

        return render(request, "standard-blog-post.html", context)
    
    def post_dispatcher(self, request, form_type):
        handlers = {
            'standard_blog_post': StandardBlogPostHandler
        }

        handler_class = handlers.get(form_type)
        if not handler_class:
            # return render(request, "error.html", {"message": "Unknown form type"})
            return HttpResponse("Unknown form type", status=400)

        handler = handler_class(request)
        return handler.handle()

    def say_hello(self, request):
        return render(request, 'hello.html', {'name': 'Vince'})

    def add(self, request):
        if request.method == "POST":
            value1 = int(request.POST["num1"])
            value2 = int(request.POST["num2"])
            res = value1 + value2
            return render(request, "result.html", {"result": res})
        return render(request, "add.html")  # Render form initially

