# WitsNote/urls.py

from django.urls import path
from WitsNote.views import *
from WitsNote.views import redirect_to_feedback_form  # ensure it's imported

WitsNoteView = WitsNoteView()

urlpatterns = [
    path('', WitsNoteView.index, name='home'),
    path('contact/', WitsNoteView.contact, name='contact'),

    # Blog
    path('topics/', WitsNoteView.topic_listing, name='topic_listing'),
    path('blog-post/', WitsNoteView.blog_post_home, name='blog_post_home'),
    path('blog-post/toggle-collection-status/', WitsNoteView.toggle_collection_status, name='toggle_collection_status'),
    path('blog-post/<slug:slug>/', WitsNoteView.post_detail, name='post_detail'),

    # Feedback
    path('create-post/redirect-to-feedback-form/', redirect_to_feedback_form, name='redirect_to_feedback_form'),

    # Create post
    path('create-post/', WitsNoteView.create_post, name='create_post'),
    path('create-post/standard-blog-post/', WitsNoteView.create_standard_blog_post, name="standard_blog_post"),
    path('create-post/case-study-blog-post/', WitsNoteView.create_case_study_post, name="case_study_blog_post"),
    path('create-post/listicle_blog_post/', WitsNoteView.create_listicle_post, name="listicle_blog_post"),
    path('create-post/infographic-post/', WitsNoteView.create_infograhic_post, name="infographic_blog_post"),
    path('create-post/<str:form_type>/', WitsNoteView.post_dispatcher, name="post_dispatcher"),

    # APIs
    path('api/gemini-proxy/', WitsNoteView.gemini_proxy, name='gemini_proxy'),
    path('api/run-ocr/', WitsNoteView.run_ocr, name='run_ocr'),
]
