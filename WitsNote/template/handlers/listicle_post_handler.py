from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post
from django.shortcuts import render

class ListiclePostHandler(BasePostHandler):
    def process_post(self):
        if self.request.method == "POST":
            title = self.request.POST.get("title")
            introduction = self.request.POST.get("introduction")
            main_content = self.request.POST.get("main_content")
            conclusion = self.request.POST.get("conclusion")
            user = self.request.user
            
            self.__save_post(title, introduction, main_content, conclusion, user)
            return render(self.request, "create-post-home.html")
        
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
        
        return post.save()