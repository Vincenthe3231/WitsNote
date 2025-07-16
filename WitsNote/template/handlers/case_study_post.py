from django.shortcuts import render
from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post

class CaseStudyPostHandler(BasePostHandler):
    def process_post(self):
        if self.request.method == "POST":
            title = self.request.POST.get("title")
            
            return self.__save_post(title)
        
        else:
            return render(self.request, "case-study-post.html")
            
    def __save_post(self, title):
        post = Post.objects.create(title=title)
        return post.save()
