from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post, PostImage
from django.shortcuts import render
from WitsNote.utils import HelperMethods, ListOfSections as section

class ListiclePostHandler(BasePostHandler):
    def process_post(self):
        helper = HelperMethods()
        is_authenticated = helper.get_user_authentication_status(self.request)
        
        if self.request.method == "POST":
            title = self.request.POST.get("title")
            introduction = self.request.POST.get("introduction")
            main_content = self.request.POST.get("main_content")
            conclusion = self.request.POST.get("conclusion")
            user = self.request.user
            
            intro_image = self.request.FILES.getlist("intro_images")
            main_image = self.request.FILES.getlist("main_images")
            conclusion_image = self.request.FILES.getlist("conclusion_images")
            
            post = self.__save_post(title, introduction, main_content, conclusion, user)
            self.__save_images(post, intro_image, section.INTRO)
            self.__save_images(post, main_image, section.MC)
            self.__save_images(post, conclusion_image, section.CONC)
            
            return render(self.request, "create-post-home.html", {"show_feedback_btn": is_authenticated})
        
        else:
            return render(self.request, "listicle-post.html")
            
            
    def __save_post(self, title, introduction, main_content, conclusion, user):
        post = Post.objects.create(
            title=title,
            introduction=introduction,
            main_content=main_content,
            conclusion=conclusion,
            user=user
        )
        
        return post
    
    def __save_images(self, post, images, section):
        post_image = PostImage.objects.create(
            post=post,
            image=images,
            section=section
        )