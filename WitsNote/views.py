from django.shortcuts import render, get_object_or_404
from .models import Post, PostImage
from users.models import PostCollection as Collection
import requests
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.views.decorators.http import require_POST, require_http_methods
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse, JsonResponse
from django.conf import settings
import json
from django.urls import reverse
from .template.handlers import *
from django.db.models import Q

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
        query = request.GET.get('q')
        if query:
            posts = Post.objects.filter(title__icontains=query).order_by('-created_at')
        else:
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
        context = {
            'posts': None,
            'show_search_bar': True,
            'collected_post_ids': [],  # add default
        }

        query = request.GET.get('q')
        if query:
            context['posts'] = Post.objects.filter(
                Q(title__icontains=query) |
                Q(introduction__icontains=query) |
                Q(content__icontains=query) |
                Q(post_type__icontains=query) |
                Q(author__username__icontains=query)
            ).order_by('-created_at')
        else:
            context['posts'] = Post.objects.prefetch_related('images').order_by('-created_at')

        # 🔄 Preload collected post IDs if user is authenticated
        if request.user.is_authenticated:
            try:
                collection = Collection.objects.get(user=request.user)
                context['collected_post_ids'] = list(collection.posts.values_list('id', flat=True))
            except Collection.DoesNotExist:
                pass

        return render(request, "blog-post-home.html", context)

    
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
    @method_decorator(require_http_methods(["GET", "POST"]), name='case_study_blog_post')
    def create_case_study_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, 'case_study_blog_post')
        else:
            self.__set_author(request)
            return render(request, "case-study-post.html", self.context)

    # Handle the standard blog post creation
    @method_decorator(require_http_methods(["GET", "POST"]), name='standard_blog_post')
    def create_standard_blog_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, "standard_blog_post")
        else:
            self.__set_author(request)
            return render(request, "standard-blog-post.html", self.context)
        
    # Handle the listicle post creation
    @method_decorator(require_http_methods(["GET", "POST"]), name='listicle_blog_post')
    def create_listicle_post(self, request):
        if request.method == "POST":
            return self.post_dispatcher(request, "listicle_post")
        else:
            self.__set_author(request)
            return render(request, "listicle-post.html", self.context)
        
    # Handle the infographic post creation
    @method_decorator(require_http_methods(["GET", "POST"]), name='infographic_blog_post')
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

    @method_decorator(login_required, name='add_to_collection')
    @method_decorator(require_POST, name='add_to_collection')
    # Handle the addition of posts to the user's collection
    def toggle_collection_status(self, request):
        try:
            data = json.loads(request.body)
            post_id = data.get('post_id')

            post = Post.objects.get(id=post_id)
            collection, _ = Collection.objects.get_or_create(user=request.user)

            if post in collection.posts.all():
                collection.posts.remove(post)
                return JsonResponse({'message': 'Post removed from collection', 'removed': True})
            else:
                collection.posts.add(post)
                return JsonResponse({'message': 'Post added to collection', 'added': True})

        except Post.DoesNotExist:
            return JsonResponse({'error': 'Post not found'}, status=404)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
        
    @method_decorator(login_required, name='redirect_to_feedback_form')
    @method_decorator(require_POST, name='redirect_to_feedback_form')
    def redirect_to_feedback_form(self, request):
        try:
            data = json.loads(request.body)

            # Optional: check for specific keys in the payload
            if data.get("trigger"):
                # Return the URL of the feedback form as a JSON response
                feedback_url = reverse('contact')  # Make sure this URL name exists
                return JsonResponse({'redirect_url': feedback_url})
            else:
                return JsonResponse({'error': 'Invalid request data'}, status=400)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

