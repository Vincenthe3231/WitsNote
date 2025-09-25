from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import ListicleSubheading, Post, PostImage
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
            post_type = "Listicle"
            user = self.request.user
            
            intro_image = self.request.FILES.getlist("intro_images")
            main_image = self.request.FILES.getlist("main_images")
            conclusion_image = self.request.FILES.getlist("conclusion_images")
            
            post = self.__save_post(title, introduction, main_content, conclusion, user, post_type)
            self.__save_images(post, intro_image, section.INTRO.value)
            self.__save_images(post, main_image, section.MC.value)
            self.__save_images(post, conclusion_image, section.CONC.value)
            self.__save_subheadings(post)



            return render(self.request, "create-post-home.html", {"show_feedback_btn": is_authenticated})
        
        else:
            return render(self.request, "listicle-post.html")
            
            
    def __save_post(self, title, introduction, main_content, conclusion, user, post_type="Listicle"):
        post = Post.objects.create(
            title=title,
            introduction=introduction,
            content=main_content,
            conclusion=conclusion,
            author=user,
            post_type=post_type
        )
        return post
    
    def __save_subheadings(self, post):
        counter = 0
        while True:
            title = self.request.POST.get(f"sub_heading_{counter}")
            content = self.request.POST.get(f"sub_content_{counter}")
            if title is None or content is None:
                break
            if title.strip() or content.strip():  # skip empty rows
                ListicleSubheading.objects.create(
                    post=post,
                    title=title.strip(),
                    content=content.strip(),
                    order=counter
                )
            counter += 1

    
    def __save_images(self, post, images, section):
        for image in images:  # iterate over each file in the list
            PostImage.objects.create(
                post=post,
                image=image,
                section=section
            )
