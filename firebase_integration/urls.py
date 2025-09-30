from django.urls import path
from .views import PublishNoteView

urlpatterns = [
    path('publish/', PublishNoteView.as_view(), name='publish_note'),
]
