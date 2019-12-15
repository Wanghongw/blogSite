import os
import json
from cnblog import settings
from django.shortcuts import render,HttpResponse,redirect
from django.http import JsonResponse
from django.contrib import auth
from blog.utils import my_forms
from django.db.models import Count,F,Q
from blog import models
from django.db import transaction
from bs4 import BeautifulSoup
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator,EmptyPage

##登陆
def login(request):
    if request.method == 'GET':
        return render(request,'login.html')
    if request.method == 'POST':
        ##获取用户输入框中的信息
        user = request.POST.get('user')
        pwd = request.POST.get('pwd')
        valid_code = request.POST.get('valid_code')
        # print(request.POST)
        ##从session中取到生成的随机字符串的数据！已经在函数get_validCode_img保存进去了
        valid_code_str = request.session.get('valid_code_str')
        ##反馈的信息
        response = {'user':None,'msg':None}
        ##比较时不区分大小写——
        if valid_code.upper() == valid_code_str.upper():
            ##用户验证模块
            user = auth.authenticate(username=user,password=pwd)
            if user:
                ##request.user为当前登陆对象——可以在模板中调用
                auth.login(request,user)
                response['user'] = user.username
            else:
                response['msg'] = '用户名或密码错误'
        else:
            response['msg'] = '验证码输入错误'
        ##返回
        return JsonResponse(response)

##获取随机验证码图片
def get_validCode_img(request):
    ##引入获取随机验证码图片的模块
    from blog.utils.valid_code import get_valid_code_img
    ##data获取
    data = get_valid_code_img(request)
    ##返回
    return HttpResponse(data)

##注册
def register(request):
    if request.method == 'GET':
        ##实例化后传给模板
        form = my_forms.UserForm()
        return render(request,'register.html',{'form':form})
    ##这里可以用is_ajax()也可以用POST判断
    if request.is_ajax():
        # print(request.POST)
        ##利用request.POST实例化form对象
        form = my_forms.UserForm(request.POST)
        ##返回的信息
        response_message = {'user':None,'msg':None}
        #认证通过
        if form.is_valid():
            response_message['user'] = form.cleaned_data.get('user')
            #生成一条用户记录
            user = form.cleaned_data.get('user')
            pwd = form.cleaned_data.get('pwd')
            email = form.cleaned_data.get('email')
            #头像对象
            avatar_obj = request.FILES.get('avatar')
            ##由于用的是用户认证的user，因此得用create_user方法往数据库中添加数据
            #avatar必须接收一个文件对象
            extra = {}
            if avatar_obj:
                extra['avatar'] = avatar_obj
            models.UserInfo.objects.create_user(username=user,password=pwd,email=email,**extra)
        else:
            response_message['msg'] = form.errors
            ##在视图中全局钩子可以利用__all__取到，也可以在模板中直接取
            # full_errors = form.errors.get('__all__')
        return JsonResponse(response_message)

##注销
def logout(request):
    ##request.session.flush()
    auth.logout(request)
    return redirect('/login/')

##主页
def index(request):
    article_list = models.Article.objects.all()
    ##评论排行榜——注意只截取前五个
    article_comment = models.Article.objects.order_by('-content_count').all()[:5]
    print(article_comment)
    ##点赞排行榜——注意只截取前五个
    article_up = models.Article.objects.order_by('-up_count').all()[:5]
    print(article_up)
    # 分页器,每页最多n条数据
    paginator = Paginator(article_list, 3)
    try:
        # 当前页，默认是第一页
        current_page_c = int(request.GET.get('page', 1))
        current_page = paginator.page(current_page_c)
        # 最多显示11个格子
        # 注意下面的判断——保证最多显示11个格子且“左5右5”，如果有越限的进行限制
        # page_range_whw存的是range对象
        if paginator.num_pages > 11:
            # “左5”越限
            if current_page_c - 5 < 1:
                page_range_whw = range(1, 11)
            # “右5”越限
            elif current_page_c + 5 > paginator.num_pages:
                page_range_whw = range(paginator.num_pages - 10, paginator.num_pages + 1)
            else:
                page_range_whw = range(current_page_c - 5, current_page_c + 6)
        else:
            page_range_whw = paginator.page_range
    except EmptyPage as e:
        current_page = paginator.page(1)
    return render(request,'index.html',locals())

##获取各种分类信息详情的视图函数
def classification(request,username):
    user = models.UserInfo.objects.filter(username=username).first()
    ##如果输入的用户不存在，直接return，不执行后面的
    if not user:
        return
    ##blog对象
    blog = user.blog
    ##找到各种分类的数据
    ##查询每一个分类名称及对应的文章数——反向查询按表名——value_list
    cats = models.Category.objects.values('pk').annotate(c=Count('article__title')).values_list('title', 'c')
    ##查询当前站点的每一个分类名称以及对应的文章数——正向查询按字段——注意这里的blog.nid是通过user找到的——value_list
    ##解决当前登陆用户登陆其他用户页面的问题，利用连续跨表找到“当前页面的作者”
    cur_cat = models.Category.objects.filter(blog_id=blog.nid).values('pk').annotate(c=Count('article__title')).values_list('title', 'c','blog_id__userinfo__username')
    ##查询当前站点每一个表签数对应的文章数——value_list
    ##解决当前登陆用户登陆其他用户页面的问题，利用连续跨表找到“当前页面的作者”
    cur_tag = models.Tag.objects.filter(blog=blog).values('pk').annotate(c=Count('article__title')).values_list('title', 'c','blog_id__userinfo__username')
    ##查询当前站点每一个年月的名称及对应的文章数
    ##解决当前登陆用户登陆其他用户页面的问题，“正向查询”，从Article表中查UserInfo表中的username，找到“当前页面的作者”
    cur_date = models.Article.objects.filter(user=user).extra(
        select={'y_m_date': 'date_format(create_date,"%%Y-%%m")'}).values('y_m_date').annotate(
        c=Count('nid')).values_list('y_m_date', 'c','user__username')
    return {'user':user,'blog':blog,'cats':cats,'cur_cat':cur_cat,'cur_tag':cur_tag,'cur_date':cur_date}

##个人站点视图函数
def home_site(request,username,**kwargs):
    data = classification(request,username)
    ##如果输入的用户不存在，data将是个NoneType，返回错误页面
    if not data:
        return render(request, 'not_found.html')
    ##查询当前用户或者站点所对应的所有文章——基于双下划线——正向查询按字段
    ##从data字典中找到user
    cur_article_list = models.Article.objects.filter(user=data.get('user'))
    # print(cur_article_list) #<QuerySet [<Article: 我是怎么把一个项目带崩的>, <Article: Linux的内存分页管理>, <Article: .net环境下跨进程、高频率读写数据>]>
    ##个人站点页面跳转
    if kwargs:
        condition = kwargs.get('condition')
        param = kwargs.get('param')  # 时间的话是2011-12
        ##基于双下划线的查询——正向查询按字段
        if condition == 'category':
            cur_article_list = cur_article_list.filter(category__title=param)
            print(cur_article_list)
        elif condition == 'tag':
            cur_article_list = cur_article_list.filter(tags__title=param)
            print(cur_article_list)
        else:# 时间的话是2011-12
            year,month = param.split('-')
            cur_article_list = cur_article_list.filter(create_date__year=year, create_date__month=month)
    ##将当前文章列表放在字典中
    cur_article_list_dict = {'cur_article_list':cur_article_list}
    ##然后将文章的数据扩展到data中
    data.update(cur_article_list_dict)
    # print('data:',data) #{'user': <UserInfo: wanghw>, 'blog': <Blog: 木叶忍者村>, 'cats': <QuerySet [('whw的文章', 2), ("xuhui's 文章", 1), ('jiao_web', 1), ('wanghw_web', 1)]>, 'cur_cat': <QuerySet [('whw的文章', 2)
    return render(request,'home_site.html',data)

##文章详情页的设计
def article_detail(request,username,article_id):
    ##调用获取各种分类信息的函数
    data = classification(request,username)
    ##根据文章nid拿到文章对象
    article_obj = models.Article.objects.filter(pk=article_id).first()
    ##字典
    art = {'article_obj':article_obj}
    ##将article_obj扩展到data字典中
    data.update(art)
    #根据某一篇文章的id构建一个这篇文章的comment_list对象
    comment_list = models.Comment.objects.filter(article_id=article_id)
    #再构建一个字典update到data中去
    c = {'comment_list':comment_list}
    data.update(c)
    return render(request,'article_detail.html',data)

##点赞
def digg(request):
    print(request.POST)
    article_id = request.POST.get('article_id')
    is_up_str = request.POST.get('is_up')#注意这里存的是字符串"true"，实际上需要布尔类型的值
    is_up = json.loads(is_up_str)#用json反序列化一下拿到布尔类型的值了
    ##点赞人就是当前登陆的人
    ##当前登陆人通过用户认证组件——request.user可以拿到！
    user_id = request.user.pk
    ##查找一下有没有点赞或者踩灭过
    obj = models.ArticleUpDown.objects.filter(user_id=user_id,article_id=article_id).first()
    ##如果没有的话进行数据库的操作
    response = {'state':True,'handled':None}
    if not obj:
        ##将数据写进数据库中点赞踩灭表中
        models.ArticleUpDown.objects.create(user_id=user_id,is_up=is_up,article_id=article_id)
        ##将文章的点赞数量+1的记录写到Article表中
        if is_up:
            models.Article.objects.filter(pk=article_id).update(up_count=F('up_count')+1)
        else:
            models.Article.objects.filter(pk=article_id).update(down_count=F('down_count')+1)
    else:
        ##表示已经操作过了，将这个状态传给ajax判断
        response['state'] = False
        #如果有值，is_up是true的话表示赞，是false的话表示踩，将点赞踩灭情况记录下来
        response['handled'] = obj.is_up
    return JsonResponse(response)##注意 JsonResponse返回

##评论的视图函数
def comment(request):
    pid = request.POST.get('pid')
    content = request.POST.get('content')
    article_id = request.POST.get('article_id')
    #用户id可以直接在request.user中取
    user_id = request.user.pk
    # 注意评论内容content不能为空，为空的话不写进数据库！
    if content == '' or content is None:
        return HttpResponse('评论内容不能为空!')
    ##评论的事物操作
    with transaction.atomic():
        #创建一个评论对象
        comment_obj = models.Comment.objects.create(user_id=user_id, article_id=article_id, content=content,
                                                    parent_comment_id=pid)
        #将文章的评论数量字段加一
        models.Article.objects.filter(pk=article_id).update(content_count=F('content_count')+1)
    #返回给回调函数的data的数据
    response = {}
    #“评论列表”中的数据需要——评论人、评论时间、评论内容
    #将这些信息都存在response字典中，最后传给回调函数
    response['username'] = request.user.username
    response['create_time'] = comment_obj.create_time.strftime('%Y-%m-%d %H:%M:%S')
    response['content'] = comment_obj.content
    #JsonResponse返回
    return JsonResponse(response)

#评论树
def get_comment_tree(request):
    #获取与这篇文章id相关的所有评论
    article_id = request.GET.get('article_id')
    #根评论一定会出现在子评论之前，加一个order_by逻辑清晰
    ret = models.Comment.objects.filter(article_id=article_id).order_by('pk').values('pk','content','parent_comment_id')
    ##ret是一个QuerySet对象，转换为list传给前端
    ret_list = list(ret)
    ##由于ret_list不是一个字典，需要设置safe=False
    return JsonResponse(ret_list,safe=False)

#后台管理页面作者文章的渲染
@login_required
def cn_backend(request):
    article_list = models.Article.objects.filter(user=request.user)
    return render(request, 'backend/backend.html', locals())

#添加文章
@login_required
def add_article(request):
    if request.method == 'GET':
        #找到当前用户的blog
        blog = request.user.blog
        ##在页面加载时渲染出文章需要所属的标签与分类
        ##标签是多对多，分类是一对多
        tag_list = models.Tag.objects.filter(blog=blog).all()
        category_list = models.Category.objects.filter(blog=blog).all()
        return render(request, 'backend/add_article.html',locals())
    if request.method == 'POST':
        category_id = request.POST.get('category_name')
        ##注意是getlist
        tags_id = request.POST.getlist('tags_name')
        title = request.POST.get('title')
        content = request.POST.get('content')

        # 防止xss攻击,过滤script标签
        soup = BeautifulSoup(content, 'html.parser')
        for tag in soup.find_all():
            print(tag.name)
            if tag.name == 'script':
                tag.decompose()
        # 构建摘要数据,获取标签字符串的文本前150个符号
        desc = soup.text[0:150] + '...'
        ##找到user_id
        user_id = models.UserInfo.objects.filter(username=request.user.username).values('pk').first()
        user_id_int = int(user_id['pk'])
        #注意category_id是一个，tags_id是多个
        ##往数据库中添加文章数据
        ##category_id是一个
        models.Article.objects.create(title=title, desc=desc, content=str(soup),user_id=user_id_int,category_id=category_id)
        # tags_id是多个，且往Article2Tag表中加
        article_id = models.Article.objects.filter(title=title).values('pk').first()
        article_id_int = int(article_id['pk'])
        #多对多的关系，所以要遍历tags_id
        for i in tags_id:
            models.Article2Tag.objects.create(article_id=article_id_int,tag_id=int(i))
        return redirect('/cn_backend/')

##编辑器上传图片
def upload(request):
    print(request.FILES)
    img_obj = request.FILES.get("upload_img")
    print(img_obj.name)
    #MEDIA_ROOT = os.path.join(BASE_DIR,'media')
    path = os.path.join(settings.MEDIA_ROOT, "add_article_img", img_obj.name)
    with open(path, "wb") as f:
        for line in img_obj:
            f.write(line)
    return HttpResponse("ok")

##添加个人博客
def add_blog(request,username):
    if request.method == 'GET':
        return render(request,'add_blog.html')
    if request.method == 'POST':
        tag = request.POST.get('tag')
        name = request.POST.get('name')
        css = request.POST.get('css')
        username = request.POST.get('username')
        response = {'tag':None,'msg':None}
        ret = models.Blog.objects.filter(Q(title=tag)|Q(site_name=name))
        ##表示已经存在这些站点信息了
        if ret:
            response['msg'] = '重复的博客标题或站点名称，请重新输入'
            return JsonResponse(response)
        else:
            response['tag'] = tag
            ##将数据写入数据库——注意UserInfo表中也得写入blog_id
            models.Blog.objects.create(title=tag,site_name=name,theme=css)
            id = models.Blog.objects.filter(title=tag).first()
            models.UserInfo.objects.filter(username=username).update(blog_id=id)
            return JsonResponse(response)

#添加标签
def add_tag(request):
    if request.method == 'GET':
        return render(request,'backend/add_tag.html')
    if request.method == 'POST':
        response = {'tag':None,'msg':None}
        tag_name = request.POST.get('tag_name')
        blog_name = request.POST.get('blog_name')
        #判断是否存在相同的tag名字
        ret = models.Tag.objects.filter(title=tag_name).first()
        if ret:
            response['msg'] = '已经有相同的标签名了'
            return JsonResponse(response)
        else:
            response['tag'] = tag_name
            #写入数据库
            blog_id = models.Blog.objects.filter(title=blog_name).values('pk').first()#{'pk': 1}
            blog_id_int = int(blog_id['pk'])
            models.Tag.objects.create(title=tag_name,blog_id=blog_id_int)
            return JsonResponse(response)

##添加分类
def add_category(request):
    if request.method == 'GET':
        return render(request,'backend/add_category.html')
    if request.method == 'POST':
        response = {'category':None,'msg':None}
        cat_name = request.POST.get('cat_name')
        blog_name = request.POST.get('blog_name')
        #判断之前有没有数据
        ret = models.Category.objects.filter(title=cat_name).first()
        if ret:
            response['msg'] = '已经存在相同的分类名了'
            return JsonResponse(response)
        else:
            response['category'] = cat_name
            #写入数据
            blog_id = models.Blog.objects.filter(title=blog_name).values('pk').first()
            blog_id_int = int(blog_id['pk'])
            models.Category.objects.create(title=cat_name,blog_id=blog_id_int)
            return JsonResponse(response)

##删除文章
def delete_article(request,article_title):
    ##删除文章，涉及的表有Article、Article2Tag、ArticleUpDown、Comment
    ##注意删除的顺序~~先删除外键关联的表，最后再删除Article表
    article_id = models.Article.objects.filter(title=article_title).values('pk').first()['pk']
    #print(article_id,type(article_id))#14 <class 'int'>
    models.Article2Tag.objects.filter(article_id=article_id).delete()
    models.ArticleUpDown.objects.filter(article_id=article_id).delete()
    models.Comment.objects.filter(article_id=article_id).delete()
    models.Article.objects.filter(nid=article_id).delete()
    return redirect('/cn_backend/')

##编辑文章
def edit(request,article_id):
    if request.method == 'GET':
        title = models.Article.objects.filter(pk=article_id).values('title').first()['title']
        content = models.Article.objects.filter(pk=article_id).values('content').first()['content']
        print(title,content)
        blog = request.user.blog
        ##在页面加载时渲染出文章需要所属的标签与分类
        ##标签是多对多，分类是一对多
        tag_list = models.Tag.objects.filter(blog=blog).all()
        category_list = models.Category.objects.filter(blog=blog).all()
        return render(request,'backend/edit.html',locals())
    #POST提交数据的时候跟“添加文章”类似，不过是在原有的基础上update
    if request.method == 'POST':
        category_id = request.POST.get('category_name')
        ##注意是getlist
        tags_id = request.POST.getlist('tags_name')
        title = request.POST.get('title')
        content = request.POST.get('content')
        # 防止xss攻击,过滤script标签
        soup = BeautifulSoup(content, 'html.parser')
        for tag in soup.find_all():
            print(tag.name)
            if tag.name == 'script':
                tag.decompose()
        # 构建摘要数据,获取标签字符串的文本前150个符号
        desc = soup.text[0:150] + '...'
        ##找到user_id
        user_id = models.UserInfo.objects.filter(username=request.user.username).values('pk').first()
        user_id_int = int(user_id['pk'])
        #注意category_id是一个，tags_id是多个
        ##往数据库中添加文章数据
        ##category_id是一个
        models.Article.objects.filter(pk=article_id).update(title=title, desc=desc, content=str(soup),user_id=user_id_int,category_id=category_id)
        # tags_id是多个，且往Article2Tag表中加
        #多对多的关系，所以要遍历tags_id
        ##由于是多对多关系，先把Article2Tag表中的记录删掉再创建
        models.Article2Tag.objects.filter(article_id=article_id).delete()
        for i in tags_id:
            models.Article2Tag.objects.create(article_id=article_id,tag_id=int(i))
        return redirect('/cn_backend/')

