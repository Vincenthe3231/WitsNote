from django import template
from django.db.models import Count
from django.db.models.functions import TruncDay, TruncMonth, TruncYear
from django.utils import timezone
from datetime import timedelta
import json

from WitsNote.models import Post

register = template.Library()

@register.inclusion_tag("admin/partials/post_analytics.html", takes_context=True)
def admin_post_analytics(context):
    """
    Renders a Posts analytics widget for the Django admin dashboard.
    Uses last 30 days, last 12 months, and all-time by year.
    """

    now = timezone.now()
    last_30 = now - timedelta(days=30)
    last_12_months = (now.replace(day=1) - timedelta(days=365))

    # Per-day (last 30 days)
    daily_qs = (
        Post.objects.filter(created_at__gte=last_30)
        .annotate(day=TruncDay("created_at"))
        .values("day")
        .annotate(count=Count("id"))
        .order_by("day")
    )
    daily_labels = [d["day"].strftime("%Y-%m-%d") for d in daily_qs]
    daily_counts = [d["count"] for d in daily_qs]

    # Per-month (last 12 months)
    monthly_qs = (
        Post.objects.filter(created_at__gte=last_12_months)
        .annotate(month=TruncMonth("created_at"))
        .values("month")
        .annotate(count=Count("id"))
        .order_by("month")
    )
    monthly_labels = [m["month"].strftime("%Y-%m") for m in monthly_qs]
    monthly_counts = [m["count"] for m in monthly_qs]

    # Per-year (all time)
    yearly_qs = (
        Post.objects.annotate(year=TruncYear("created_at"))
        .values("year")
        .annotate(count=Count("id"))
        .order_by("year")
    )
    yearly_labels = [y["year"].strftime("%Y") for y in yearly_qs]
    yearly_counts = [y["count"] for y in yearly_qs]

    data = {
        "daily": {"labels": daily_labels, "counts": daily_counts},
        "monthly": {"labels": monthly_labels, "counts": monthly_counts},
        "yearly": {"labels": yearly_labels, "counts": yearly_counts},
    }

    return {
        "request": context.get("request"),
        # JSON so we can safely read in JS via json_script
        "analytics_json": json.dumps(data),
        # Also provide tabular data for the table view
        "daily_rows": list(zip(daily_labels, daily_counts)),
        "monthly_rows": list(zip(monthly_labels, monthly_counts)),
        "yearly_rows": list(zip(yearly_labels, yearly_counts)),
    }
