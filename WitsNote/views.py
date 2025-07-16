from django.shortcuts import render
from .models import Post
from django.http import HttpResponse, HttpRequest
from django.conf import settings
# from .template.handlers.standard_blog_post import StandardBlogPostHandler
# from .template.handlers.case_study_post import CaseStudyPostHandler
# from .template.handlers.listicle_post_handler import ListiclePostHandler
from .template.handlers import *

# from django.contrib.auth.models import User, auth

# Create your views here.

class WitsNoteView:
    def __init__(self):
       self.context = {
            'gemini_api_key': settings.GEMINI_API_KEY,
            'gemini_api_url': settings.GEMINI_API_URL,
            'author': None,
            
        } 

    def __set_author(self, request):
        self.context['author'] = request.user.username  
        

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
        self.__set_author(request)
        return render(request, "post-detail.html", {'post': post})

    ''' ---  Handle All the Post Creation --- '''
    
    # Handle the case study post creation
    def create_case_study_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, 'case_study_post')
        else:
            self.__set_author(request)
            return render(request, "case-study-post.html", self.context)

    # Handle the standard blog post creation
    def create_standard_blog_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, "standard_blog_post")
        else:
            self.__set_author(request)
            return render(request, "standard-blog-post.html", self.context)
        
    # Handle the listicle post creation
    def create_listicle_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, "listicle_post")
        else:
            self.__set_author(request)
            return render(request, "listicle-post.html", self.context)
        
    # Handle the infographic post creation
    def create_infograhic_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, "infographic_post")
        else:
            self.__set_author(request)
            return render(request, "infographic-post.html", self.context)

    # Dispatch the HttpRequest to the corresponding form handler
    def post_dispatcher(self, request, form_type):
        handlers = {
            'standard_blog_post': StandardBlogPostHandler,
            'case_study_post': CaseStudyPostHandler,
            'listicle_post': ListiclePostHandler,
            'infographic_post': InfographicPostHandler
        }

        handler_class = handlers.get(form_type)
        if not handler_class:
            # return render(request, "error.html", {"message": "Unknown form type"})
            return HttpResponse("Unknown form type", status=400)

        handler = handler_class(request)
        return handler.handle()

    ''' --- Demonstration from YouTube Video --- '''

    def say_hello(self, request):
        return render(request, 'hello.html', {'name': 'Vince'})

    def add(self, request):
        if request.method == "POST":
            value1 = int(request.POST["num1"])
            value2 = int(request.POST["num2"])
            res = value1 + value2
            return render(request, "result.html", {"result": res})
        return render(request, "add.html")  # Render form initially

