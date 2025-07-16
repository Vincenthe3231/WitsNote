from django.urls import path
from WitsNote.views import WitsNoteView

WitsNoteView = WitsNoteView()

urlpatterns = [
    path('', WitsNoteView.index, name='home'),
    path('contact/', WitsNoteView.contact, name='contact'),
    path('topics/', WitsNoteView.topic_listing, name='topic_listing'),
    path('create-post/', WitsNoteView.create_post, name='create_post'),
    path('create-post/standard-blog-post/', WitsNoteView.create_standard_blog_post, name="standard_blog_post"),
    path('create-post/case-study-blog-post/', WitsNoteView.create_case_study_post, name="case_study_blog_post"),
    path('create-post/create-listicle-post/', WitsNoteView.create_listicle_post, name="listicle_blog_post"),
    path('create-post/infographic-post/', WitsNoteView.create_infograhic_post, name="infographic_blog_post"),
    path('create-post/<str:form_type>/', WitsNoteView.post_dispatcher, name="post_dispatcher"),
    # path('hello/', WitsNoteView.say_hello),
    # path('add/', WitsNoteView.add),
    
]