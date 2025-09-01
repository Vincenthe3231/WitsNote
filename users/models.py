from django.db import models
from django.contrib.auth.models import User
from WitsNote.models import Post
from phonenumber_field.modelfields import PhoneNumberField

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile")
    phone = models.CharField(max_length=200)
    profession = models.CharField(max_length=40)
    work_link = models.URLField(max_length=200, help_text="Link to portfolio or LinkedIn")
    skills = models.TextField(help_text="Comma-separated skills (e.g. Python, Django, REST)")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"[{self.user.id}]-[{self.user.first_name} {self.user.last_name}]"
    
    class Meta:
        db_table = "users_userprofile"

class PostCollection(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    posts = models.ManyToManyField(Post, related_name="collections")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Collection by {self.user.username} - {self.created_at.strftime('%Y-%m-%d')}"