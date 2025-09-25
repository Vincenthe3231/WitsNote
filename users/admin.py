from django.contrib import admin
from .models import UserProfile
from django.utils.html import format_html
from django.urls import reverse

# Register your models here.
@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'profession', 'phone', 'created_at', 'pfp_tag')
    search_fields = ('user__first_name', 'user__last_name', 'profession')
    list_filter = ('profession', 'created_at')
    ordering = ('-created_at',)
    readonly_fields = ('created_at',)
    autocomplete_fields = ['user']

    def pfp_tag(self, obj):
        if obj.profile_picture:
            return format_html('<img src="{}" style="max-height: 100px;"/>', obj.profile_picture.url)
        return "-"
    pfp_tag.short_description = 'Profile Picture'

    # Show the User related information after clicking the link in UserProfile
    def linked_user(self, obj):
        if obj.user:
            link = reverse("admin:auth_user_change", args=[obj.user.id])
            return format_html('<a href="{}">{} {}</a>', link, obj.user.first_name, obj.user.last_name)
        return "-"
    linked_user.short_description = "User"
    linked_user.admin_order_field = 'user'  # Allows column sorting