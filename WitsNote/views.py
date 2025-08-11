from django.shortcuts import render, get_object_or_404
from .models import Post, PostImage
import requests
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, JsonResponse
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

    @csrf_exempt  # optional if using POST from JavaScript
    def call_gemini(request):
        if request.method != "POST":
            return JsonResponse({'error': 'Only POST allowed'}, status=405)

        try:
            # Get input from frontend JSON body
            import json
            data = json.loads(request.body)
            prompt = data.get('prompt')

            # Prepare Gemini API request
            gemini_url = settings.GEMINI_API_URL
            gemini_key = settings.GEMINI_API_KEY

            response = requests.post(
                gemini_url,
                headers={
                    "Authorization": f"Bearer {gemini_key}",
                    "Content-Type": "application/json"
                },
                json={
                    "contents": [{"parts": [{"text": prompt}]}],
                    "generationConfig": {
                        "maxOutputTokens": 256
                    }
                }
            )

            return JsonResponse(response.json(), status=response.status_code)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

    def contact(self, request):
        return render(request, "contact.html")
    
    def topic_listing(self, request):
        return render(request, "topics-listing.html")
    
    # Prefetch images efficiently for each blog post listed
    def blog_post_home(self, request):
        posts = Post.objects.prefetch_related('images').order_by('-created_at')
        return render(request, "blog-post-home.html", {'posts': posts})
    
    # Fetch post with its related images in one go
    def post_detail(self, request, slug):
        post = get_object_or_404(Post.objects.prefetch_related('images'), slug=slug)
        self.__set_author(request)
        return render(request, "post-detail.html", {'post': post})
    
    def create_post(self, request):
        show_feedback_btn = True
        return render(request, "create-post-home.html", {'show_feedback_btn': show_feedback_btn})

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
            return self.post_dispatcher(request, "infographic_blog_post")
        else:
            self.__set_author(request)
            return render(request, "infographic-post.html", self.context)

    # Dispatch the HttpRequest to the corresponding form handler
    def post_dispatcher(self, request, form_type):
        handlers = {
            'standard_blog_post': StandardBlogPostHandler,
            'case_study_post': CaseStudyPostHandler,
            'listicle_post': ListiclePostHandler,
            'infographic_blog_post': InfographicPostHandler
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

