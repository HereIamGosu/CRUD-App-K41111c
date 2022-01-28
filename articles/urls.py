from django.urls import path

from . import views

urlpatterns = [
    path("", views.home, name="home"),
    path("new/", views.create_article, name="create_article"),
    path(
        "article/<int:article_id>/<slug:slug>/",
        views.article_detail,
        name="article_detail",
    ),
    path(
        "article/edit/<int:article_id>/",
        views.edit_article,
        name="edit_article",
    ),
    path(
        "article/delete/<int:article_id>/",
        views.delete_article,
        name="delete_article",
    ),
]
