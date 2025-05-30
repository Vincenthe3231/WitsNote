from django.urls import path
from WitsNote.views import WitsNoteView

WitsNoteView = WitsNoteView()

urlpatterns = [
    path('', WitsNoteView.index, name='home'),
    path('contact/', WitsNoteView.contact, name='contact'),
    path('topics/', WitsNoteView.topic_listing, name='topic_listing'),
    path('hello/', WitsNoteView.say_hello),
    path('add/', WitsNoteView.add),
    
]