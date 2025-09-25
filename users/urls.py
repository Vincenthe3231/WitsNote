from django.urls import path
from .views import UserProfileView

UserProfileView = UserProfileView()

urlpatterns = [
    path('user-profile/', UserProfileView.user_profile, name='user_profile' ),
    path('profile-setup/', UserProfileView.profile_setup, name='profile_setup'),
    path('add-skill/', UserProfileView.add_skill, name='add_skill'),
    path('remove-skill/', UserProfileView.remove_skill, name='remove_skill'),
    path('add-work-link/', UserProfileView.add_work_link, name='add_work_link'),
    path('remove-work-link/', UserProfileView.remove_work_link, name='remove_work_link'),
    path('update-profile/', UserProfileView.update_profile, name='update_profile'),
    path("upload-profile-pic/", UserProfileView.upload_profile_pic, name="upload_profile_pic"),
]