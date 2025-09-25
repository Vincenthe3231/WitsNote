from WitsNote.template.base_handler import BasePostHandler
from WitsNote.models import Post, InfographicSection
from django.shortcuts import render, redirect
from WitsNote.utils import HelperMethods

class InfographicPostHandler(BasePostHandler):

    def process_post(self):
        helper = HelperMethods()
        is_authenticated = helper.get_user_authentication_status(self.request)

        if self.request.method == "POST":
            # Get the post title from form
            post_title = self.request.POST.get("title", "").strip()
            if not post_title:
                post_title = "Untitled Infographic"

            # Create the main infographic post
            post = Post.objects.create(
                title=post_title,
                introduction="",  
                content="",        
                conclusion="",     
                author=self.request.user,
                post_type="Infographic"
            )

            # Save each infographic section
            titles = self.request.POST.getlist("section_titles[]")
            contents = self.request.POST.getlist("section_texts[]")

            for idx, (title, content) in enumerate(zip(titles, contents), start=1):
                if title.strip() or content.strip():  
                    InfographicSection.objects.create(
                        post=post,
                        title=title.strip(),
                        content=content.strip(),
                        order=idx
                    )

            # Redirect to detail view of this post
            return render(self.request, "create-post-home.html", {"show_feedback_btn": is_authenticated})

        else:
            return render(self.request, "infographic-post.html")
