from django.contrib import admin
from django.urls import reverse
from .models import Post, ListicleSubheading, InfographicSection, PostImage
from django.utils.html import format_html
from django.utils.timezone import is_naive, make_aware
from django.db.models import Count
from zoneinfo import ZoneInfo
from django.db.models.functions import TruncDay
import pytz
    
class ListicleSubheadingInline(admin.TabularInline):
    model = ListicleSubheading
    extra = 1
    fields = ('order', 'title', 'content')


class InfographicSectionInline(admin.TabularInline):
    model = InfographicSection
    extra = 1
    fields = ('order', 'title', 'content')
    
@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'author_link', 'created_at_gmt8')
    search_fields = ('title', 'content')
    list_filter = ('author', 'created_at')
    inlines = [ListicleSubheadingInline, InfographicSectionInline]

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
    
@admin.register(PostImage)
class PostImageAdmin(admin.ModelAdmin):
    list_display = ('post', 'section', 'uploaded_at', 'image_tag')
    search_fields = ('post__title', 'section')
    list_filter = ('section', 'uploaded_at', 'post')

    def image_tag(self, obj):
        if obj.image:
            return format_html('<img src="{}" style="max-height: 100px;"/>', obj.image.url)
        return "-"
    image_tag.short_description = 'Image'