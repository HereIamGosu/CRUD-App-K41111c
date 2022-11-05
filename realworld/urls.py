from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path("", include("gosu.articles.urls")),
    path("", include("gosu.accounts.urls")),
    path("comments/", include("gosu.comments.urls")),
    path("admin/", admin.site.urls),
]
