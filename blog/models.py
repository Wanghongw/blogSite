from django.db import models
from django.contrib.auth.models import AbstractUser

##用户信息
##这张用户信息表与User均继承自AbstractUser，要想用用户认证组件且表用自己下面新建的，
##还可以新增字段，需要在settings里设置：AUTH_USER_MODEL = 'blog.UserInfo'
class UserInfo(AbstractUser):
    nid = models.AutoField(primary_key=True)
    telephone = models.CharField(max_length=11,null=True,unique=True)
    create_time = models.DateTimeField(verbose_name='创建时间',auto_now_add=True)
    ##头像是一个FileField——注意这里必须是“相对路径”，不能是/avatars/这样的绝对路径
    avatar = models.FileField(upload_to='avatars/',default='avatars/default.jpg')
    #用户与blog是一对一关系
    blog = models.OneToOneField(to='Blog',to_field='nid',null=True,on_delete=True)
    def __str__(self):
        return self.username

##博客信息表（站点表）
class Blog(models.Model):
    nid = models.AutoField(primary_key=True)
    title = models.CharField(max_length=66,verbose_name='个人博客标题')
    site_name = models.CharField(max_length=66,verbose_name='站点名称')
    theme = models.CharField(max_length=66,verbose_name='博客主题')
    def __str__(self):
        return self.title

##博主个人文章分类表
class Category(models.Model):
    nid = models.AutoField(primary_key=True)
    title = models.CharField(max_length=32,verbose_name='分类标题')
    ##跟blog是一对多的关系
    blog = models.ForeignKey(to='Blog',to_field='nid',verbose_name='所属博客',on_delete=True)
    def __str__(self):
        return self.title

##文章属标签
class Tag(models.Model):
    nid = models.AutoField(primary_key=True)
    title = models.CharField(max_length=32,verbose_name='标签名称')
    ##跟blog是一对多的关系
    blog = models.ForeignKey(to='Blog',to_field='nid',verbose_name='所属博客',on_delete=True)
    def __str__(self):
        return self.title

##文章类
class Article(models.Model):
    ##普通字段
    nid = models.AutoField(primary_key=True)
    title = models.CharField(max_length=32,verbose_name='文章标题')
    desc = models.CharField(max_length=255,verbose_name='文章描述')
    create_date = models.DateTimeField(auto_now_add=True,verbose_name='创建时间')
    content = models.TextField()
    ##每生成一个文章评论、每点一次赞、每踩一次，都在下列字段加一，牺牲了增删改的效率，提高了查询的效率，
    ##查询这些信息的时候不用跨表查询了
    ##默认值设置为0
    content_count = models.IntegerField(default=0)
    up_count = models.IntegerField(default=0)
    down_count = models.IntegerField(default=0)
    ##关系表
    #文章跟作者是多对一的关系
    user = models.ForeignKey(to='UserInfo',to_field='nid',verbose_name='文章作者',on_delete=True)
    #文章跟分类是一对多的关系
    category = models.ForeignKey(to='Category',to_field='nid',verbose_name='文章分类',on_delete=True)
    #文章跟标签是多对多的关系
    #中建模型
    tags = models.ManyToManyField(
        to='Tag',
        through='Article2Tag',
        through_fields=('article','tag'),
    )
    def __str__(self):
        return self.title

##Article与Tag是多对多的关系，需要中间关联的一张表
class Article2Tag(models.Model):
    nid = models.AutoField(primary_key=True)
    article = models.ForeignKey(to='Article',to_field='nid',verbose_name='文章',on_delete=True)
    tag = models.ForeignKey(to='Tag',to_field='nid',verbose_name='标签',on_delete=True)
    ##article与tag字段联合唯一
    class Meta:
        unique_together = [
            ('article','tag'),
        ]
    def __str__(self):
        s = self.article.title + '——' + self.tag.title
        return s

##点赞、踩灭表——哪一个用户对那一篇文章进行了点赞、踩灭
class ArticleUpDown(models.Model):
    nid = models.AutoField(primary_key=True)
    #跟UserInfo表示一对多的关系,允许空值
    user = models.ForeignKey(to='UserInfo',to_field='nid',null=True,on_delete=True)
    #跟文章表是一对多的关系，允许空值
    article = models.ForeignKey(to='Article',to_field='nid',null=True,on_delete=True)
    #点赞状态——True代表赞，False代表踩
    is_up = models.BooleanField(default=True)
    #联合唯一
    class Meta:
        unique_together = [
            ('article','user'),
        ]

##评论表
##根评论：对文章的评论；子评论：对评论的评论
class Comment(models.Model):
    nid = models.AutoField(primary_key=True)
    ##哪一个用户对哪一篇文章在什么时间进行了什么评论
    ##跟UserInfo是一对多的关系
    user =models.ForeignKey(to='UserInfo',to_field='nid',verbose_name='评论者',on_delete=True)
    ##跟文章是一对多的关系
    article = models.ForeignKey(to='Article',to_field='nid',verbose_name='评论文章',on_delete=True)
    create_time = models.DateTimeField(auto_now_add=True,verbose_name='创建时间')
    content = models.CharField(max_length=255,verbose_name='评论内容')
    ##父评论，用于区别评论的评论，null代表是对文章的评论
    ##自关联
    parent_comment = models.ForeignKey(to='self',to_field='nid',null=True,on_delete=True)
    def __str__(self):
        return self.content









