from django.contrib import admin
from django.urls import reverse
from .models import Post
from django.utils.html import format_html
from django.utils.timezone import is_naive, make_aware
from django.db.models import Count
from zoneinfo import ZoneInfo
from django.db.models.functions import TruncDay
import pytz


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'author_link', 'created_at_gmt8')
    search_fields = ('title', 'content')
    list_filter = ('author', 'created_at')

    def author_link(self, obj):
        url = reverse("admin:auth_user_change", args=[obj.author.id])
        return format_html('<a href="{}">{}</a>', url, obj.author.username)
    author_link.admin_order_field = 'author'
    author_link.short_description = 'Author'

    def created_at_gmt8(self, obj):
        gmt8 = pytz.timezone("Asia/Kuala_Lumpur")  # GMT+8
        created_at = obj.created_at

        # Make sure the datetime is timezone-aware
        if is_naive(created_at):
            created_at = make_aware(created_at)

        local_time = created_at.astimezone(gmt8)
        return local_time.strftime("%Y-%m-%d %H:%M:%S")
    
    created_at_gmt8.admin_order_field = 'created_at'
    created_at_gmt8.short_description = 'Created At (GMT+8)'