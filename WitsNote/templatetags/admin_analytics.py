from django import template
from django.db.models import Count
from django.utils import timezone
from datetime import timedelta
from WitsNote.models import Post # Import your Post model correctly

register = template.Library()

@register.inclusion_tag('admin_analytics/posts_per_day.html')
def admin_post_analytics():

    # 1. Get posts created in the last 7 days
    seven_days_ago = timezone.now() - timedelta(days=7)
    
    # 2. Annotate the count of posts per creation day
    daily_posts = Post.objects.filter(
        created_at__gte=seven_days_ago
    ).extra(select={'date': 'date(created_at)'}).values('date').annotate(count=Count('id')).order_by('date')
    
    # 3. Format the data for the template
    data = [
        {'date': entry['date'].strftime('%Y-%m-%d'), 'count': entry['count']}
        for entry in daily_posts
    ]
    
    return {'daily_posts': data}