from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post
from django.shortcuts import render, redirect

class InfographicPostHandler(BasePostHandler):
    
    def process_post(self):
        if self.request.method == "POST":
            title = self.request.POST.get("title")
            content = self.request.POST.get("content")

            self.__save_post(title, content)       
            
        else:
            return redirect("infographic_post")

    def __save_post(self, title, content):
        post = Post.objects.create(
            title=title,
            content=content,
        )
        return post.save()