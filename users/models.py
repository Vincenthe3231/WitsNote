from django.db import models
from django.contrib.auth.models import User
from phonenumber_field.modelfields import PhoneNumberField

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=True, blank=True)
    phone = PhoneNumberField(unique=False, blank=True, null=True)
    profession = models.CharField(max_length=40)
    work_link = models.URLField(max_length=200, help_text="Link to portfolio or LinkedIn")
    skills = models.TextField(help_text="Comma-separated skills (e.g. Python, Django, REST)")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.first_name + ' ' + self.user.last_name}'s Profile"
