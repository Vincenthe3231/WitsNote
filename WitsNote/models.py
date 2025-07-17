from django.db import models
from django.contrib.auth.models import User
from django.utils.text import slugify
from django.utils.crypto import get_random_string

# Create your models here.

class Post(models.Model):
    title = models.CharField(max_length=200)
    thumbnail = models.ImageField(upload_to='thumbnails/')
    introduction = models.TextField()
    content = models.TextField()
    conclusion = models.TextField()
    slug = models.SlugField(max_length=200, unique=True, blank=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=False, blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            base_slug = slugify(self.title)
            slug = base_slug
            num = 1
            while Post.objects.filter(slug=slug).exists():
                slug = f"{base_slug}-{num}"
                num += 1
            self.slug = slug
        super().save(*args, **kwargs)

    
    def __str__(self):
        return f"{self.title} by {self.author.username}."

    class Meta:
        db_table = 'witsnote_post'
        
class PostImage(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='images')
    image = models.ImageField(upload_to='post_images/')
    section = models.CharField(max_length=50)   # introduction, main content, conclusion
    uploaded_at = models.DateTimeField(auto_now_add=True)