from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post
from django.shortcuts import render, redirect

class InfographicPostHandler(BasePostHandler):
    
    def process_post(self):
        if self.request.method == "POST":
            titles = self.request.POST.getlist("section_titles[]")
            contents = self.request.POST.getlist("section_texts[]")

            for title, content in zip(titles, contents):
                self.__save_post(title, content)

        else:
            return redirect("infographic_blog_post")

    def __save_post(self, title, content):
        post = Post.objects.create(
            title=title,
            content=content,
            author=self.request.user
        )
        return post.save()