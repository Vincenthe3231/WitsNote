from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post
from django.shortcuts import render
from WitsNote.utils import HelperMethods

class InfographicPostHandler(BasePostHandler):
    
    def process_post(self):
        helper = HelperMethods()
        is_authenticated = helper.get_user_authentication_status(self.request)
        post_type = "infographic"

        if self.request.method == "POST":
            titles = self.request.POST.getlist("section_titles[]")
            contents = self.request.POST.getlist("section_texts[]")

            for title, content in zip(titles, contents):
                self.__save_post(title, content)

        else:
            return render(self.request, "infographic-post.html", {"show_feedback_btn": is_authenticated})

    def __save_post(self, title, content):
        post = Post.objects.create(
            title=title,
            content=content,
            author=self.request.user
        )
        return post.save()