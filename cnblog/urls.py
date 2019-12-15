"""cnblog URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,re_path
from blog import views
from django.views.static import serve
from cnblog import settings

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', views.login),
    path('index/', views.index),
    #点赞
    path('digg/',views.digg),
    #访问127.0.0.1:8000直接进index
    path('',views.index),
    #评论
    path('comment/',views.comment),
    ##评论树
    path('get_comment_tree/',views.get_comment_tree),
    # 后台管理url
    path('cn_backend/',views.cn_backend),
    # 后台管理-添加标签
    path('cn_backend/add_tag/',views.add_tag),
    #后台管理-添加分类
    path('cn_backend/add_category/',views.add_category),
    #后台管理-添加文章
    re_path('cn_backend/add_article/$',views.add_article),
    #后台管理-删除文章
    re_path('^cn_backend/delete_article/(?P<article_title>\w+)/$',views.delete_article),
    #后台管理-编辑文章
    re_path('^cn_backend/edit/(?P<article_id>\d+)/$',views.edit),
    # 文本编辑器上传图片url
    path('upload/', views.upload),
    #随机图片验证码
    re_path(r'^get_validCode_img/$', views.get_validCode_img),
    re_path(r'^register/$',views.register),
    ##media配置——配合settings中的MEDIA_ROOT的配置，就可以在浏览器的地址栏访问media文件夹及里面的文件了
    re_path(r'media/(?P<path>.*)$',serve,{'document_root':settings.MEDIA_ROOT}),
    ##注销
    re_path(r'^logout/$',views.logout),
    ##个人站点url
    re_path(r'^(?P<username>\w+)/$',views.home_site),#home_site(request,username='wanghw')
    ##个人页面跳转
    #home_site(request,username='wanghw',condition='tag',param='王宏伟web')
    #其中condition与param是字典的形式：{'condition':'tag','param':'王宏伟web'}
    re_path(r'^(?P<username>\w+)/(?P<condition>tag|category|archive)/(?P<param>.*)/$',views.home_site),
    ##文章详情页的设计
    re_path(r'^(?P<username>\w+)/articles/(?P<article_id>\d+)/$',views.article_detail),
    ##添加个人博客
    re_path(r'^(?P<username>\w+)/add_blog/$',views.add_blog),

]
