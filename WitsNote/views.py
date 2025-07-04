from django.shortcuts import render
from .models import Post
from django.http import HttpResponse
from django.conf import settings
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
            title = request.POST.get("title")
            published_date = request.POST.get("published_date")
            introduction = request.POST.get("introduction")
            main_content = request.POST.get("main_content")
            conclusion = request.POST.get("conclusion")

            # Here you would typically save the post to the database
            # For example:
            Post.objects.create(
                title=title,
                published_date=published_date,
                introduction=introduction,
                main_content=main_content,
                conclusion=conclusion,
                author=request.user.username
            )

        return render(request, "standard-blog-post.html", context)

    def say_hello(self, request):
        return render(request, 'hello.html', {'name': 'Vince'})

    def add(self, request):
        if request.method == "POST":
            value1 = int(request.POST["num1"])
            value2 = int(request.POST["num2"])
            res = value1 + value2
            return render(request, "result.html", {"result": res})
        return render(request, "add.html")  # Render form initially

