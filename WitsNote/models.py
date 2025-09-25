from django.db import models
from django.urls import reverse
from django.contrib.auth.models import User
from django.utils.text import slugify
from django.utils.crypto import get_random_string

# Create your models here.

class Post(models.Model):
    POST_TYPE_CHOICES = [
        ("Standard", "standard"),
        ("Case Study", "case_study"),
        ("Listicle", "listicle"),
        ("Infographic", "infographic"),
    ]
    title = models.CharField(max_length=200)
    post_type = models.CharField(max_length=50, choices=POST_TYPE_CHOICES, default="Standard")
    thumbnail = models.ImageField(upload_to='thumbnails/')
    introduction = models.TextField()
    content = models.TextField()
    conclusion = models.TextField()
    slug = models.SlugField(max_length=200, unique=True, blank=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE, null=False, blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    @property
    def intro_images(self):
        return self.images.filter(section__in=["introduction"])

    @property
    def main_images(self):
        return self.images.filter(section__in=["main_content", "ListOfSections.MAIN"])

    @property
    def conclusion_images(self):
        return self.images.filter(section__in=["conclusion", "ListOfSections.CONCLUSION"])
    
    @property
    def literature_review_images(self):
        return self.images.filter(section__in=["literature_review"])

    @property
    def methodology_images(self):
        return self.images.filter(section__in=["methodology"])

    @property
    def results_images(self):
        return self.images.filter(section__in=["results"])

    @property
    def discussion_images(self):
        return self.images.filter(section__in=["discussion"])

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
    
    def get_absolute_url(self):
        return reverse('post_detail', kwargs={'slug': self.slug})

    class Meta:
        db_table = 'witsnote_post'
        
class PostImage(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='images')
    image = models.ImageField(upload_to='post_images/')
    section = models.CharField(max_length=50)   # introduction, main content, conclusion
    uploaded_at = models.DateTimeField(auto_now_add=True)
    
    def save(self, *args, **kwargs):
        # normalize section before save
        mapping = {
            "Introduction": "introduction",
            "Main Content": "main_content",
            "Conclusion": "conclusion",
            "Literature Review": "literature_review",
            "Methodology": "methodology",
            "Results": "results",
            "Discussion": "discussion",
        }
        if self.section in mapping:
            self.section = mapping[self.section]
        super().save(*args, **kwargs)
    
    def __str__(self):
        queries = []
        if self.post.id == 1:
            queries.append(f"Image for {self.post.id}st - {self.section}")
        elif self.post.id == 2:
            queries.append(f"Image for {self.post.id}nd - {self.section}")
        elif self.post.id == 3:
            queries.append(f"Image for {self.post.id}rd - {self.section}")
        else:
            queries.append(f"Image for {self.post.id}th - {self.section}")
        return ", ".join(queries)
    
class ListicleSubheading(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name="subheadings")
    title = models.CharField(max_length=255)
    content = models.TextField(default="")
    order = models.PositiveIntegerField(default=0)

    class Meta:
        ordering = ["order"]

    def __str__(self):
        return f"{self.order}. {self.title}"
