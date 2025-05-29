from django.db import models

# Create your models here.
class UserProfile(models.Model):
    # user_id = models.BigIntegerField(primary_key=True)  # Explicitly set user_id as primary key
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    profession = models.CharField(max_length=40)
    work_link = models.TextField()
    skills = models.TextField(help_text="Comma-separated skills")
    # email = models.EmailField(max_length=30, unique=True) # Enforce uniqueness
    # password = models.CharField(max_length=30)
    created_at = models.DateTimeField(auto_now_add=True)
