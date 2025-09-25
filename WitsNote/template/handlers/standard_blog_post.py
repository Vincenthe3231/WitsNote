from django.http import HttpResponse
from django.shortcuts import render
from ..base_handler import BasePostHandler
from WitsNote.models import Post, PostImage
from WitsNote.utils import HelperMethods, ListOfSections as section


class StandardBlogPostHandler(BasePostHandler):
    
    def __init__(self, request):
        super().__init__(request)

        # Define all the section of this template
        # self.__section = {
        #     "a": "introduction",
        #     "b": "main_content",
        #     "c": "conclusion"
        # }
    
    def process_post(self) -> HttpResponse:

        helper = HelperMethods()
        is_authenticated = helper.get_user_authentication_status(self.request)

        # Implement the logic for processing a standard blog post
        if self.request.method == "POST":
            title = self.request.POST.get("title", "")
            # published_date = self.request.POST.get("published_date", "")
            introduction = self.request.POST.get("introduction", "")
            main_content = self.request.POST.get("main_content", "")
            conclusion = self.request.POST.get("conclusion", "")
            user = self.request.user
            
            # Read the uploaded files
            intro_image = self.request.FILES.getlist("intro_images")
            main_image = self.request.FILES.getlist("main_images")
            conclusion_image = self.request.FILES.getlist("conclusion_images")

            print(intro_image, main_image, conclusion_image)

            # Save the post
            post = self.__save_post(title, introduction, main_content, conclusion, user)
            
            # Save the uploaded images
            self.__save_images(post, intro_image, section=section.INTRO.value)
            self.__save_images(post, main_image, section=section.MC.value)
            self.__save_images(post, conclusion_image, section=section.CONC.value)

            return render(self.request, "create-post-home.html", {"show_feedback_btn": is_authenticated})
        else:
            return render(self.request, "standard-blog-post.html")

    def __save_post(self, title, introduction, main_content, conclusion, user):
        post = Post.objects.create(
            title=title,
            introduction=introduction,
            content=main_content,
            conclusion=conclusion,
            author=user
        )
        return post
    
    def __save_images(self, post, images, section):
        for image in images:
            PostImage.objects.create(
                post=post,
                image=image,
                section=section
            )
