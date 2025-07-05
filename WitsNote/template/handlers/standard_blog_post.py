from django.http import HttpResponse
from django.shortcuts import render
from ..base_handler import BasePostHandler
from WitsNote.models import Post

class StandardBlogPostHandler(BasePostHandler):
    def process_post(self) -> HttpResponse:
        # Implement the logic for processing a standard blog post
        if self.request.method == "POST":
            title = self.request.POST.get("title", "")
            published_date = self.request.POST.get("published_date", "")
            introduction = self.request.POST.get("introduction", "")
            main_content = self.request.POST.get("main_content", "")
            conclusion = self.request.POST.get("conclusion", "")
            user = self.request.user

            self.__save_post(title, introduction, main_content, conclusion, user)
            return render(self.request, "create-post-home.html")
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
        return post.save()