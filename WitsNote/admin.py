from django.contrib import admin
from django.urls import reverse
from .models import Post
from django.utils.html import format_html
from django.db.models import Count
from django.db.models.functions import TruncDay


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'author_link', 'created_at')
    search_fields = ('title', 'content')
    list_filter = ('author', 'created_at')
    
    def author_link(self, obj):
        # if Post.author is a foreign key to User
        url = reverse("admin:auth_user_change", args=[obj.author.id])
        return format_html('<a href="{}">{}</a>', url, obj.author.username)
    author_link.admin_order_field = 'author'   # enables sorting by author
    author_link.short_description = 'Author'  # column header
    
# extend the default context
old_each_context = admin.site.each_context

def custom_each_context(request):
    context = old_each_context(request)

    daily_posts = (
        Post.objects.annotate(day=TruncDay("created_at"))
        .values("day")
        .annotate(count=Count("id"))
        .order_by("day")
    )

    context["daily_posts"] = list(daily_posts)
    return context

admin.site.each_context = custom_each_context