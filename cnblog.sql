/*
Navicat MySQL Data Transfer

Source Server         : mysqlwhw
Source Server Version : 50640
Source Host           : localhost:3306
Source Database       : cnblog

Target Server Type    : MYSQL
Target Server Version : 50640
File Encoding         : 65001

Date: 2018-09-16 13:44:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add user', '6', 'add_userinfo');
INSERT INTO `auth_permission` VALUES ('17', 'Can change user', '6', 'change_userinfo');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete user', '6', 'delete_userinfo');
INSERT INTO `auth_permission` VALUES ('19', 'Can add article', '7', 'add_article');
INSERT INTO `auth_permission` VALUES ('20', 'Can change article', '7', 'change_article');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete article', '7', 'delete_article');
INSERT INTO `auth_permission` VALUES ('22', 'Can add article2 tag', '8', 'add_article2tag');
INSERT INTO `auth_permission` VALUES ('23', 'Can change article2 tag', '8', 'change_article2tag');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete article2 tag', '8', 'delete_article2tag');
INSERT INTO `auth_permission` VALUES ('25', 'Can add article up down', '9', 'add_articleupdown');
INSERT INTO `auth_permission` VALUES ('26', 'Can change article up down', '9', 'change_articleupdown');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete article up down', '9', 'delete_articleupdown');
INSERT INTO `auth_permission` VALUES ('28', 'Can add blog', '10', 'add_blog');
INSERT INTO `auth_permission` VALUES ('29', 'Can change blog', '10', 'change_blog');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete blog', '10', 'delete_blog');
INSERT INTO `auth_permission` VALUES ('31', 'Can add category', '11', 'add_category');
INSERT INTO `auth_permission` VALUES ('32', 'Can change category', '11', 'change_category');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete category', '11', 'delete_category');
INSERT INTO `auth_permission` VALUES ('34', 'Can add comment', '12', 'add_comment');
INSERT INTO `auth_permission` VALUES ('35', 'Can change comment', '12', 'change_comment');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete comment', '12', 'delete_comment');
INSERT INTO `auth_permission` VALUES ('37', 'Can add tag', '13', 'add_tag');
INSERT INTO `auth_permission` VALUES ('38', 'Can change tag', '13', 'change_tag');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete tag', '13', 'delete_tag');

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `content` longtext NOT NULL,
  `content_count` int(11) NOT NULL,
  `up_count` int(11) NOT NULL,
  `down_count` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_article_category_id_7e38f15e_fk_blog_category_nid` (`category_id`),
  KEY `blog_article_user_id_5beb0cc1_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `blog_article_category_id_7e38f15e_fk_blog_category_nid` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`nid`),
  CONSTRAINT `blog_article_user_id_5beb0cc1_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article
-- ----------------------------
INSERT INTO `blog_article` VALUES ('1', '我是怎么把一个项目带崩的', '我是一名项目经理，在过去的四个月里，我把一个项目带崩了（上线后频出问题，用户无法使用）。在最近的几天，我每天都在反思自己，我都在问自己以下几个问题： 1.我做错了什么？ 2.我在其中占有多重的因素？ 以下内容，我将回答以上问题，并在最后说一下我的补救措施。 项目和团队背景 首先给大家说明一下项目背景 ...', '2018-08-24 00:57:14.134654', '......', '10', '5', '2', '1', '9');
INSERT INTO `blog_article` VALUES ('3', '藏在正则表达式里的陷阱', '一个正则表达式竟然能导致CPU100%异常？ 快来看看是怎么回事！ ...', '2018-08-24 01:00:14.668518', '......', '0', '2', '1', '2', '10');
INSERT INTO `blog_article` VALUES ('4', '从 docker 到 runC', '前几天，我司出了个篓子。当时正值某喜闻乐见的关键比赛结束，一堆人打开我司app准备看点东西，结果从来没有感受到过这么多关注量的该功能瞬间幸福到眩晕，触发了熔断，结果就是大量兴致冲冲打开app准备看该比赛结果的人被迫刷了十分钟三天前的野外跑酷，负责内容的人火大到直接骂娘。 虽然这个业务不是我负责，但是 ...', '2018-08-24 01:00:52.918720', '<div class=\"post\">\r\n	<h1 class=\"postTitle\"><a id=\"cb_post_title_url\" class=\"postTitle2\" href=\"https://www.cnblogs.com/paulwhw/p/9466758.html\">django的forms认证组件</a></h1>\r\n	<div id=\"cnblogs_post_body\" class=\"blogpost-body cnblogs-markdown\"><h1 id=\"django的forms认证组件\">django的forms认证组件</h1>\r\n<h5 id=\"每个网站的注册界面都需要有相应的认证功能比如说认证注册页面的用户名是否已被注册二次输入的密码是否一致以及认证用户输入的用户名邮箱手机号等字段是否符合程序员所指定的规则等等当然不同的web框架有不同的实现方式本文介绍django的forms组件的实现方法\">每个网站的注册界面都需要有相应的“认证”功能，比如说认证注册页面的用户名是否已被注册，二次输入的密码是否一致以及认证用户输入的用户名、邮箱、手机号等字段是否符合程序员所指定的“规则”等等。当然，不同的web框架有不同的实现方式，本文介绍django的forms组件的实现方法。</h5>\r\n<h2 id=\"默认的校验规则\">默认的校验规则</h2>\r\n<h5 id=\"默认的校验规则都是校验单个字段而且格式是固定的\">默认的校验规则都是校验单个字段而且格式是固定的：</h5>\r\n<h4 id=\"建表\">建表</h4>\r\n<h5 id=\"models.py文件为数据库中创建下面字段\">models.py文件为数据库中创建下面字段：</h5>\r\n<pre><code class=\"hljs haskell\"><span class=\"hljs-title\">from</span> django.db <span class=\"hljs-keyword\">import</span> models\r\n<span class=\"hljs-class\"><span class=\"hljs-keyword\">class</span> <span class=\"hljs-type\">UserInfo</span>(<span class=\"hljs-title\">models</span>.<span class=\"hljs-type\">Model</span>):\r\n    name = models.<span class=\"hljs-type\">CharField</span>(<span class=\"hljs-title\">max_length</span>=32)\r\n    pwd = models.<span class=\"hljs-type\">CharField</span>(<span class=\"hljs-title\">max_length</span>=32)\r\n    email = models.<span class=\"hljs-type\">EmailField</span>()\r\n    tel = models.<span class=\"hljs-type\">CharField</span>(<span class=\"hljs-title\">max_length</span>=32)</span></code></pre>\r\n<h4 id=\"模板文件\">模板文件</h4>\r\n<h5 id=\"模板文件我们引用bootstrap并且利用模板语言进行渲染得到相应的页面\">模板文件我们引用bootstrap，并且利用模板语言进行渲染得到相应的页面：</h5>\r\n<pre><code class=\"hljs django\"><span class=\"xml\"><span class=\"hljs-meta\">&lt;!DOCTYPE html&gt;</span>\r\n<span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">html</span> <span class=\"hljs-attr\">lang</span>=<span class=\"hljs-string\">\"en\"</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">head</span>&gt;</span>\r\n    <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">meta</span> <span class=\"hljs-attr\">charset</span>=<span class=\"hljs-string\">\"UTF-8\"</span>&gt;</span>\r\n    <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">title</span>&gt;</span>Forms组件<span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">title</span>&gt;</span>\r\n    <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">link</span> <span class=\"hljs-attr\">rel</span>=<span class=\"hljs-string\">\"stylesheet\"</span> <span class=\"hljs-attr\">href</span>=<span class=\"hljs-string\">\"/static/bootstrap-3.3.7/css/bootstrap.css\"</span>&gt;</span>\r\n    <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">link</span> <span class=\"hljs-attr\">rel</span>=<span class=\"hljs-string\">\"stylesheet\"</span> <span class=\"hljs-attr\">href</span>=<span class=\"hljs-string\">\"/static/whw_css.css\"</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">head</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">body</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">h3</span>&gt;</span>注册页面<span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">h3</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">div</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"container\"</span>&gt;</span>\r\n    <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">div</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"row\"</span>&gt;</span>\r\n        <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">div</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"col-md-6 col-lg-offset-3\"</span>&gt;</span>\r\n           <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">form</span> <span class=\"hljs-attr\">action</span>=<span class=\"hljs-string\">\"\"</span> <span class=\"hljs-attr\">method</span>=<span class=\"hljs-string\">\"post\"</span> <span class=\"hljs-attr\">novalidate</span> &gt;</span>\r\n            </span><span class=\"hljs-template-tag\">{% <span class=\"hljs-name\"><span class=\"hljs-name\">csrf_token</span></span> %}</span><span class=\"xml\">\r\n            <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">p</span>&gt;</span>用户名 </span><span class=\"hljs-template-variable\">{{ form.name }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">span</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"pull-right\"</span>&gt;</span></span><span class=\"hljs-template-variable\">{{ form.name.errors.0 }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">span</span>&gt;</span><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">p</span>&gt;</span>\r\n            <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">p</span>&gt;</span>密码 </span><span class=\"hljs-template-variable\">{{ form.pwd }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">span</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"pull-right\"</span>&gt;</span></span><span class=\"hljs-template-variable\">{{ form.pwd.errors.0 }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">span</span>&gt;</span><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">p</span>&gt;</span>\r\n            <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">p</span>&gt;</span>确认密码 </span><span class=\"hljs-template-variable\">{{ form.r_pwd }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">span</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"pull-right\"</span>&gt;</span></span><span class=\"hljs-template-variable\">{{ form.r_pwd.errors.0 }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">span</span>&gt;</span><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">span</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"pull-right\"</span>&gt;</span></span><span class=\"hljs-template-variable\">{{ full_errors.0 }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">span</span>&gt;</span><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">p</span>&gt;</span>\r\n            <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">p</span>&gt;</span>邮箱 </span><span class=\"hljs-template-variable\">{{ form.email }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">span</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"pull-right\"</span>&gt;</span></span><span class=\"hljs-template-variable\">{{ form.email.errors.0 }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">span</span>&gt;</span><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">p</span>&gt;</span>\r\n            <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">p</span>&gt;</span>手机号 </span><span class=\"hljs-template-variable\">{{ form.tel }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">span</span> <span class=\"hljs-attr\">class</span>=<span class=\"hljs-string\">\"pull-right\"</span>&gt;</span></span><span class=\"hljs-template-variable\">{{ form.tel.errors.0 }}</span><span class=\"xml\"><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">span</span>&gt;</span><span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">p</span>&gt;</span>\r\n            <span class=\"hljs-tag\">&lt;<span class=\"hljs-name\">input</span> <span class=\"hljs-attr\">type</span>=<span class=\"hljs-string\">\"submit\"</span> <span class=\"hljs-attr\">value</span>=<span class=\"hljs-string\">\"确认\"</span>&gt;</span>\r\n        <span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">form</span>&gt;</span>\r\n        <span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">div</span>&gt;</span>\r\n    <span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">div</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">div</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">body</span>&gt;</span>\r\n<span class=\"hljs-tag\">&lt;/<span class=\"hljs-name\">html</span>&gt;</span> </span></code></pre>\r\n<h4 id=\"校验模块\">校验模块</h4>\r\n<h5 id=\"为了使程序易于维护且解耦性高一点我们把认证功能写在一个模块my_forms.py里在里面定义一个专门用于认证的类userform\">为了使程序易于维护且解耦性高一点，我们把认证功能写在一个模块<code>my_forms.py</code>里，在里面定义一个专门用于认证的类<code>UserForm</code>:</h5>\r\n<pre><code class=\"hljs python\"><span class=\"hljs-comment\">#先引入相应的模块</span>\r\n<span class=\"hljs-keyword\">from</span> django <span class=\"hljs-keyword\">import</span> forms\r\n<span class=\"hljs-keyword\">from</span> django.forms <span class=\"hljs-keyword\">import</span> widgets\r\n<span class=\"hljs-keyword\">from</span> app01.models <span class=\"hljs-keyword\">import</span> UserInfo\r\n<span class=\"hljs-keyword\">from</span> django.core.exceptions <span class=\"hljs-keyword\">import</span> NON_FIELD_ERRORS,ValidationError\r\n\r\n<span class=\"hljs-comment\">#做校验的类，后面跟着校验规则</span>\r\n<span class=\"hljs-class\"><span class=\"hljs-keyword\">class</span> <span class=\"hljs-title\">UserForm</span><span class=\"hljs-params\">(forms.Form)</span>:</span>\r\n    <span class=\"hljs-comment\">##校验字段</span>\r\n    name = forms.CharField(min_length=<span class=\"hljs-number\">4</span>,label=<span class=\"hljs-string\">\'用户名\'</span>,widget=widgets.TextInput(attrs={<span class=\"hljs-string\">\'class\'</span>:<span class=\"hljs-string\">\'form-control\'</span>}),error_messages={<span class=\"hljs-string\">\'required\'</span>:<span class=\"hljs-string\">\'输入不能为空\'</span>})\r\n\r\n    email = forms.EmailField(label=<span class=\"hljs-string\">\'邮箱\'</span>,widget=widgets.TextInput(attrs={<span class=\"hljs-string\">\'class\'</span>:<span class=\"hljs-string\">\'form-control\'</span>}),error_messages={<span class=\"hljs-string\">\'required\'</span>:<span class=\"hljs-string\">\'输入不能为空\'</span>,<span class=\"hljs-string\">\'invalid\'</span>:<span class=\"hljs-string\">\'请输入邮箱格式\'</span>})\r\n\r\n    pwd = forms.CharField(min_length=<span class=\"hljs-number\">4</span>,label=<span class=\"hljs-string\">\'密码\'</span>,widget=widgets.PasswordInput(attrs={<span class=\"hljs-string\">\'class\'</span>:<span class=\"hljs-string\">\'form-control\'</span>}),error_messages={<span class=\"hljs-string\">\'required\'</span>:<span class=\"hljs-string\">\'输入不能为空\'</span>})\r\n\r\n    r_pwd = forms.CharField(min_length=<span class=\"hljs-number\">4</span>,label=<span class=\"hljs-string\">\'确认密码\'</span>,widget=widgets.PasswordInput(attrs={<span class=\"hljs-string\">\'class\'</span>:<span class=\"hljs-string\">\'form-control\'</span>}),error_messages={<span class=\"hljs-string\">\'required\'</span>:<span class=\"hljs-string\">\'输入不能为空\'</span>})\r\n\r\n    tel = forms.CharField(label=<span class=\"hljs-string\">\'手机号\'</span>,widget=widgets.TextInput(attrs={<span class=\"hljs-string\">\'class\'</span>:<span class=\"hljs-string\">\'form-control\'</span>}),error_messages={<span class=\"hljs-string\">\'required\'</span>:<span class=\"hljs-string\">\'输入不能为空\'</span>})</code></pre>\r\n<h5 id=\"参数说明\">参数说明：</h5>\r\n<pre><code class=\"hljs scala\">(<span class=\"hljs-number\">1</span>)min_length=<span class=\"hljs-number\">4</span>表示输入的字符的长度不能小于<span class=\"hljs-number\">4</span>\r\n(<span class=\"hljs-number\">2</span>)widget=widgets.<span class=\"hljs-type\">TextInput</span>(attrs={<span class=\"hljs-symbol\">\'clas</span>s\':<span class=\"hljs-symbol\">\'form</span>-control\'}) 这句话表示输入框input的<span class=\"hljs-class\"><span class=\"hljs-keyword\">type</span></span>=<span class=\"hljs-symbol\">\'tex</span>t\'，且<span class=\"hljs-class\"><span class=\"hljs-keyword\">class</span></span>=<span class=\"hljs-symbol\">\'form</span>-control\'\r\n(<span class=\"hljs-number\">3</span>)error_messages是在用户输入不符合校验规则时做出的说明，是一个字典的形式。注意字典里的key值是固定的！\r\n</code></pre>\r\n<h4 id=\"视图函数\">视图函数</h4>\r\n<h5 id=\"views.py文件的内容如下\">views.py文件的内容如下：</h5>\r\n<pre><code class=\"hljs python\"><span class=\"hljs-keyword\">from</span> django.shortcuts <span class=\"hljs-keyword\">import</span> render,HttpResponse\r\n<span class=\"hljs-comment\">##引入校验的类</span>\r\n<span class=\"hljs-keyword\">from</span> app01.my_forms <span class=\"hljs-keyword\">import</span> UserForm\r\n\r\n<span class=\"hljs-comment\">#视图函数</span>\r\n<span class=\"hljs-function\"><span class=\"hljs-keyword\">def</span> <span class=\"hljs-title\">my_forms</span><span class=\"hljs-params\">(request)</span>:</span>\r\n    <span class=\"hljs-keyword\">if</span> request.method == <span class=\"hljs-string\">\'GET\'</span>:\r\n        form = UserForm()\r\n        <span class=\"hljs-keyword\">return</span> render(request, <span class=\"hljs-string\">\'index.html\'</span>,{<span class=\"hljs-string\">\'form\'</span>:form})\r\n\r\n    <span class=\"hljs-keyword\">if</span> request.method == <span class=\"hljs-string\">\'POST\'</span>:\r\n        <span class=\"hljs-comment\">#form表单的name属性值应当与forms组件的字段名称一致</span>\r\n        form = UserForm(request.POST)\r\n        print(form.is_valid())\r\n        <span class=\"hljs-keyword\">if</span> form.is_valid():\r\n            print(form.cleaned_data)\r\n            <span class=\"hljs-comment\">#只有全部验证成功了才执行</span>\r\n            <span class=\"hljs-keyword\">return</span> HttpResponse(<span class=\"hljs-string\">\'OK!\'</span>)\r\n        <span class=\"hljs-keyword\">else</span>:\r\n            print(form.errors)\r\n            <span class=\"hljs-comment\">#带着参数返回当前页面</span>\r\n            <span class=\"hljs-keyword\">return</span> render(request,<span class=\"hljs-string\">\'index.html\'</span>,locals())</code></pre>\r\n<h5 id=\"如上面的代码所示我们用userform类以及前端返回的参数实例化出一个类form\">如上面的代码所示，我们用<code>UserForm</code>类以及<code>前端返回的参数</code>实例化出一个类<code>form</code>:</h5>\r\n<pre><code class=\"hljs lisp\">form = UserForm(<span class=\"hljs-name\">request</span>.POST)</code></pre>\r\n<h5 id=\"这里有一个is_valid方法返回布尔类型的值只有当全部字段校验成功后它的值才为true\">这里有一个<code>is_valid()</code>方法，返回布尔类型的值。只有当全部字段校验成功后它的值才为True。</h5>\r\n<h5 id=\"最终校验成功的字段存到了form.cleaned_data里校验失败的字段以及对应的错误信息放在了form.errors里将这两个字典类型的数据传给模板我们就可以看到对应的信息了\">最终校验成功的字段存到了<code>form.cleaned_data</code>里；校验失败的字段以及对应的错误信息放在了<code>form.errors</code>里。将这两个“字典”类型的数据传给模板我们就可以看到对应的信息了：</h5>\r\n<p><img src=\"https://i.imgur.com/uky5vzb.jpg\"></p>\r\n<h4 id=\"自定义校验规则与多个字段的校验\">自定义校验规则与多个字段的校验</h4>\r\n<h5 id=\"一自定义校验规则我们用到局部钩子如果我们想校验属性name那么可以在userform类中我们定义一个方法名字固定为clean_name\">一、自定义校验规则我们用到<code>局部钩子</code>。如果我们想校验属性name，那么可以在<code>UserForm</code>类中我们定义一个方法，名字固定为<code>clean_name</code>：</h5>\r\n<pre><code class=\"hljs python\"><span class=\"hljs-comment\">##校验数据库中是否有相同的用户名</span>\r\n<span class=\"hljs-function\"><span class=\"hljs-keyword\">def</span> <span class=\"hljs-title\">clean_name</span><span class=\"hljs-params\">(self)</span>:</span>\r\n    val = self.cleaned_data.get(<span class=\"hljs-string\">\'name\'</span>)\r\n    <span class=\"hljs-comment\">#数据库中检测</span>\r\n    ret = UserInfo.objects.filter(name=val)\r\n    <span class=\"hljs-keyword\">if</span> <span class=\"hljs-keyword\">not</span> ret:\r\n        <span class=\"hljs-keyword\">return</span> val\r\n    <span class=\"hljs-comment\">#如果ret有值表示数据库中有这条记录了</span>\r\n    <span class=\"hljs-keyword\">else</span>:\r\n        <span class=\"hljs-keyword\">raise</span> ValidationError(<span class=\"hljs-string\">\'该用户已注册\'</span>)</code></pre>\r\n<p><img src=\"https://i.imgur.com/GyIcx72.jpg\"></p>\r\n<h5 id=\"注意这个方法名固定必须是clean_s的形式这里的s就是校验的属性的名字比如说我们想校验手机号必须为11位可以这样写\">注意这个方法名固定，必须是<code>clean_%s</code>的形式，这里的<code>%s</code>就是校验的属性的名字。比如说我们想校验手机号必须为11位可以这样写：</h5>\r\n<pre><code class=\"hljs python\"><span class=\"hljs-function\"><span class=\"hljs-keyword\">def</span> <span class=\"hljs-title\">clean_tel</span><span class=\"hljs-params\">(self)</span>:</span>\r\n    val = self.cleaned_data.get(<span class=\"hljs-string\">\'tel\'</span>)\r\n    <span class=\"hljs-keyword\">if</span> len(val) == <span class=\"hljs-number\">11</span>:\r\n        <span class=\"hljs-keyword\">return</span> val\r\n    <span class=\"hljs-keyword\">else</span>:\r\n        <span class=\"hljs-keyword\">raise</span> ValidationError(<span class=\"hljs-string\">\'手机号必须为11位\'</span>)</code></pre>\r\n<p><img src=\"https://i.imgur.com/1UTlqgK.jpg\"></p>\r\n<h5 id=\"二进行多个字段的校验我们用到全局钩子\">二、进行多个字段的校验我们用到<code>全局钩子</code></h5>\r\n<h5 id=\"如果我们想校验两次收入的密码是否一致可以在userform中定义一个方法clean\">如果我们想校验两次收入的密码是否一致可以在<code>UserForm</code>中定义一个方法<code>clean</code>:</h5>\r\n<pre><code class=\"hljs python\"><span class=\"hljs-function\"><span class=\"hljs-keyword\">def</span> <span class=\"hljs-title\">clean</span><span class=\"hljs-params\">(self)</span>:</span>\r\n    pwd = self.cleaned_data.get(<span class=\"hljs-string\">\'pwd\'</span>)\r\n    r_pwd = self.cleaned_data.get(<span class=\"hljs-string\">\'r_pwd\'</span>)\r\n    <span class=\"hljs-keyword\">if</span> pwd <span class=\"hljs-keyword\">and</span> r_pwd:\r\n        <span class=\"hljs-keyword\">if</span> pwd == r_pwd:\r\n            <span class=\"hljs-keyword\">return</span> self.cleaned_data\r\n        <span class=\"hljs-keyword\">else</span>:\r\n            <span class=\"hljs-keyword\">raise</span> ValidationError(<span class=\"hljs-string\">\'两次密码不一致\'</span>)\r\n    <span class=\"hljs-keyword\">else</span>:\r\n        <span class=\"hljs-keyword\">return</span> self.cleaned_data</code></pre>\r\n<p><img src=\"https://i.imgur.com/TceAYoi.jpg\"></p>\r\n</div><div id=\"MySignature\"></div>\r\n<div class=\"clear\"></div>\r\n<div id=\"blog_post_info_block\">\r\n<div id=\"BlogPostCategory\">分类: <a href=\"https://www.cnblogs.com/paulwhw/category/1262979.html\" target=\"_blank\">Django</a></div>\r\n<div id=\"EntryTag\"></div>\r\n<div id=\"blog_post_info\"><div id=\"green_channel\">\r\n        <a href=\"javascript:void(0);\" id=\"green_channel_digg\" onclick=\"DiggIt(9466758,cb_blogId,1);green_channel_success(this,\'谢谢推荐！\');\">好文要顶</a>', '0', '1', '1', '4', '10');
INSERT INTO `blog_article` VALUES ('5', '.net环境下跨进程、高频率读写数据1', '\n\r\n		一种比较普遍的tag类型是只是渲染其它模块显示下内容，这样的类型叫做Inclusion Tag。\r\n	\n\r\n		例如，实现以下tag：\r\n	\n\r\n		{% books_for_author author %}\r\n	\n\r\n		渲染结果为：\r\n	\n\n\n\r\n				<ul>\r\n<li>The C...', '2018-08-24 01:01:34.269277', '<div class=\"blogpost-body\" id=\"cnblogs_post_body\">\n<div>\r\n		一种比较普遍的tag类型是只是渲染其它模块显示下内容，这样的类型叫做Inclusion Tag。\r\n	</div>\n<div>\r\n		例如，实现以下tag：\r\n	</div>\n<div>\r\n		{% books_for_author author %}\r\n	</div>\n<div>\r\n		渲染结果为：\r\n	</div>\n<div>\n<div>\n<div>\r\n				&lt;<strong>ul</strong>&gt;<br/>\r\n&lt;<strong>li</strong>&gt;The Cat In The Hat&lt;/<strong>li</strong>&gt;<br/>\r\n&lt;<strong>li</strong>&gt;Hop On Pop&lt;/<strong>li</strong>&gt;<br/>\r\n&lt;<strong>li</strong>&gt;Green Eggs And Ham&lt;/<strong>li</strong>&gt;<br/>\r\n&lt;/<strong>ul</strong>&gt;\r\n			</div>\n</div>\n</div>\n<div>\r\n		列出某个作者所有的书。\r\n	</div>\n<ul>\n<li>\r\n			定义函数\r\n		</li>\n</ul>\n<div>\n<div>\n<strong>def</strong> books_for_author(author):<br/>\r\n    books = Book.objects.<strong>filter</strong>(authors__id=author.<strong>id</strong>)<br/>\r\n    <strong>return</strong> {\'books\': books}\r\n		</div>\n</div>\n<ul>\n<li>\r\n			创建另一个模板文件book_snippet.html\r\n		</li>\n</ul>\n<div>\n<div>\r\n			&lt;<strong>ul</strong>&gt;<br/>\r\n{% for book in books %}<br/>\r\n&lt;<strong>li</strong>&gt;{{ book.<strong>title</strong> }}&lt;/<strong>li</strong>&gt;<br/>\r\n{% endfor %}<br/>\r\n&lt;/<strong>ul</strong>&gt;\r\n		</div>\n</div>\n<ul>\n<li>\r\n			注册tag\r\n		</li>\n</ul>\n<div>\r\n		register.inclusion_tag(\'book_snippet.html\')(books_for_author)\r\n	</div>\n<div>\r\n		 \r\n	</div>\n<div>\r\n		有些你的模板可以使用父模板的context内容，Django提供一个takes_context参数来实现，\r\n	</div>\n<div>\r\n		使用之后，tag不能再带参数，\r\n	</div>\n<div>\n<div>\n<div>\r\n				@register.inclusion_tag(\'link.html\', takes_context=<strong>True</strong>)<br/>\n<strong>def</strong> jump_link(context):<br/>\r\n    <strong>return</strong> {<br/>\r\n        \'link\': context[\'home_link\'],<br/>\r\n        \'title\': context[\'home_title\'],<br/>\r\n}\r\n			</div>\r\n模板文件link.html为\r\n		</div>\n</div>\n<div>\n<div>\r\n			Jump directly to &lt;a href=\"{{ link }}\"&gt;{{ title }}&lt;/a&gt;.\r\n		</div>\n</div>\n<div>\r\n		使用方法：\r\n	</div>\n<div>\n<div>\r\n			{% jump_link %}\r\n		</div>\n<div>\r\n			 \r\n		</div>\n<div>\r\n			转自： http://www.cnblogs.com/btchenguang/archive/2012/09/05/2672364.html\r\n		</div>\n</div>\n</div>', '1', '2', '2', '5', '9');
INSERT INTO `blog_article` VALUES ('7', '123123驱蚊器翁', '驱蚊器翁群翁去...', '2018-09-15 17:37:49.090853', '驱蚊器翁群翁去', '1', '1', '0', '11', '14');
INSERT INTO `blog_article` VALUES ('8', '1323123ad', 'dasdadddd...', '2018-09-15 21:12:10.202006', 'dasdadddd', '0', '0', '0', '11', '14');
INSERT INTO `blog_article` VALUES ('9', 'ddddddddddddddddddd', 'ddddddddddddddddddddddddd...', '2018-09-15 21:12:20.684549', 'ddddddddddddddddddddddddd', '1', '1', '0', '11', '14');
INSERT INTO `blog_article` VALUES ('10', '333333333', '3333333...', '2018-09-15 21:25:02.028116', '3333333', '0', '0', '0', '11', '14');
INSERT INTO `blog_article` VALUES ('11', '111111111111111', '33333333333...', '2018-09-15 21:25:11.481085', '33333333333', '0', '0', '0', '11', '14');
INSERT INTO `blog_article` VALUES ('17', 'Linux的内存管理', '<h1>哈哈哈哈哈哈哈</h1>...', '2018-09-16 00:35:52.788664', '&lt;h1&gt;哈哈哈哈哈哈哈&lt;/h1&gt;', '1', '1', '0', '5', '9');
INSERT INTO `blog_article` VALUES ('18', '三国群英', '<h1>aaaaaaaaasdasdaaaaaaa</h1>...', '2018-09-16 00:36:44.849335', '&lt;h1&gt;aaaaaaaaasdasdaaaaaaa&lt;/h1&gt;', '0', '0', '0', '8', '9');
INSERT INTO `blog_article` VALUES ('20', '多对多', '\r\n	驱蚊器翁\r\n...', '2018-09-16 08:17:13.596050', '<h1>\r\n	驱蚊器翁\r\n</h1>', '1', '1', '0', '12', '13');
INSERT INTO `blog_article` VALUES ('21', 'sss', '...', '2018-09-16 08:52:39.116890', '<img alt=\"\" border=\"0\" src=\"http://127.0.0.1:8000/static/blog/kindeditor/plugins/emoticons/images/11.gif\"/>', '3', '0', '1', '13', '15');
INSERT INTO `blog_article` VALUES ('22', '飘雪', '\r\n	哈哈哈哈哈哈哈\n...', '2018-09-16 10:29:44.295850', '<h1>\r\n	哈哈哈哈哈哈哈<img alt=\"\" border=\"0\" src=\"http://127.0.0.1:8000/static/blog/kindeditor/plugins/emoticons/images/10.gif\"/>\n</h1>', '5', '1', '0', '14', '16');

-- ----------------------------
-- Table structure for blog_article2tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_article2tag`;
CREATE TABLE `blog_article2tag` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `blog_article2tag_article_id_tag_id_b0745f42_uniq` (`article_id`,`tag_id`),
  KEY `blog_article2tag_tag_id_389b9a96_fk_blog_tag_nid` (`tag_id`),
  CONSTRAINT `blog_article2tag_article_id_753a2b60_fk_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`nid`),
  CONSTRAINT `blog_article2tag_tag_id_389b9a96_fk_blog_tag_nid` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article2tag
-- ----------------------------
INSERT INTO `blog_article2tag` VALUES ('2', '1', '1');
INSERT INTO `blog_article2tag` VALUES ('4', '3', '4');
INSERT INTO `blog_article2tag` VALUES ('7', '4', '2');
INSERT INTO `blog_article2tag` VALUES ('6', '5', '1');
INSERT INTO `blog_article2tag` VALUES ('11', '7', '11');
INSERT INTO `blog_article2tag` VALUES ('17', '17', '1');
INSERT INTO `blog_article2tag` VALUES ('18', '17', '3');
INSERT INTO `blog_article2tag` VALUES ('19', '17', '5');
INSERT INTO `blog_article2tag` VALUES ('21', '18', '3');
INSERT INTO `blog_article2tag` VALUES ('22', '18', '5');
INSERT INTO `blog_article2tag` VALUES ('23', '18', '6');
INSERT INTO `blog_article2tag` VALUES ('28', '20', '7');
INSERT INTO `blog_article2tag` VALUES ('29', '20', '8');
INSERT INTO `blog_article2tag` VALUES ('30', '20', '9');
INSERT INTO `blog_article2tag` VALUES ('31', '21', '13');
INSERT INTO `blog_article2tag` VALUES ('32', '22', '14');

-- ----------------------------
-- Table structure for blog_articleupdown
-- ----------------------------
DROP TABLE IF EXISTS `blog_articleupdown`;
CREATE TABLE `blog_articleupdown` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `is_up` tinyint(1) NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `blog_articleupdown_article_id_user_id_fa3d0c08_uniq` (`article_id`,`user_id`),
  KEY `blog_articleupdown_user_id_2c0ebe49_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `blog_articleupdown_article_id_9be1a8a2_fk_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`nid`),
  CONSTRAINT `blog_articleupdown_user_id_2c0ebe49_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_articleupdown
-- ----------------------------
INSERT INTO `blog_articleupdown` VALUES ('13', '0', '3', '9');
INSERT INTO `blog_articleupdown` VALUES ('14', '1', '5', '9');
INSERT INTO `blog_articleupdown` VALUES ('15', '1', '1', '9');
INSERT INTO `blog_articleupdown` VALUES ('17', '1', '1', '10');
INSERT INTO `blog_articleupdown` VALUES ('18', '0', '5', '10');
INSERT INTO `blog_articleupdown` VALUES ('19', '1', '3', '10');
INSERT INTO `blog_articleupdown` VALUES ('20', '1', '4', '10');
INSERT INTO `blog_articleupdown` VALUES ('23', '0', '1', '13');
INSERT INTO `blog_articleupdown` VALUES ('24', '0', '5', '13');
INSERT INTO `blog_articleupdown` VALUES ('25', '1', '7', '14');
INSERT INTO `blog_articleupdown` VALUES ('26', '0', '4', '14');
INSERT INTO `blog_articleupdown` VALUES ('27', '1', '9', '14');
INSERT INTO `blog_articleupdown` VALUES ('30', '1', '17', '9');
INSERT INTO `blog_articleupdown` VALUES ('31', '1', '20', '13');
INSERT INTO `blog_articleupdown` VALUES ('32', '1', '3', '15');
INSERT INTO `blog_articleupdown` VALUES ('33', '1', '1', '15');
INSERT INTO `blog_articleupdown` VALUES ('34', '1', '5', '15');
INSERT INTO `blog_articleupdown` VALUES ('35', '0', '21', '15');
INSERT INTO `blog_articleupdown` VALUES ('36', '1', '1', '16');
INSERT INTO `blog_articleupdown` VALUES ('37', '1', '22', '16');
INSERT INTO `blog_articleupdown` VALUES ('38', '1', '1', null);

-- ----------------------------
-- Table structure for blog_blog
-- ----------------------------
DROP TABLE IF EXISTS `blog_blog`;
CREATE TABLE `blog_blog` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(66) NOT NULL,
  `site_name` varchar(66) NOT NULL,
  `theme` varchar(66) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_blog
-- ----------------------------
INSERT INTO `blog_blog` VALUES ('1', '木叶忍者村', 'wanghw', 'whw.css');
INSERT INTO `blog_blog` VALUES ('2', '异乡异客', 'jiaoxuhui', 'jiao.css');
INSERT INTO `blog_blog` VALUES ('4', '比格披萨', 'pizza', 'pizza.css');
INSERT INTO `blog_blog` VALUES ('5', '小小的小小', 'xiaoxiao', 'xiaoxiao.css');
INSERT INTO `blog_blog` VALUES ('6', '大王大王', 'dawang', 'sss.css');
INSERT INTO `blog_blog` VALUES ('7', '飘雪', 'xuexue', 'xuexue.css');

-- ----------------------------
-- Table structure for blog_category
-- ----------------------------
DROP TABLE IF EXISTS `blog_category`;
CREATE TABLE `blog_category` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `blog_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_category_blog_id_80f0723a_fk_blog_blog_nid` (`blog_id`),
  CONSTRAINT `blog_category_blog_id_80f0723a_fk_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_category
-- ----------------------------
INSERT INTO `blog_category` VALUES ('1', 'whw的文章', '1');
INSERT INTO `blog_category` VALUES ('2', 'xuhui\'s 文章', '2');
INSERT INTO `blog_category` VALUES ('3', 'wanghw_web', '1');
INSERT INTO `blog_category` VALUES ('4', 'jiao_web', '2');
INSERT INTO `blog_category` VALUES ('5', '火星分类', '1');
INSERT INTO `blog_category` VALUES ('6', '火星分类2', '1');
INSERT INTO `blog_category` VALUES ('7', '火星分类3', '1');
INSERT INTO `blog_category` VALUES ('8', '火星分类4', '1');
INSERT INTO `blog_category` VALUES ('9', '火星分类5', '1');
INSERT INTO `blog_category` VALUES ('10', '嚯嚯嚯', '1');
INSERT INTO `blog_category` VALUES ('11', '小小哈哈', '5');
INSERT INTO `blog_category` VALUES ('12', '披萨666', '4');
INSERT INTO `blog_category` VALUES ('13', 'wwwq', '6');
INSERT INTO `blog_category` VALUES ('14', '大雪雪', '7');

-- ----------------------------
-- Table structure for blog_comment
-- ----------------------------
DROP TABLE IF EXISTS `blog_comment`;
CREATE TABLE `blog_comment` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `content` varchar(255) NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_comment_article_id_3d58bca6_fk_blog_article_nid` (`article_id`),
  KEY `blog_comment_parent_comment_id_26791b9a_fk_blog_comment_nid` (`parent_comment_id`),
  KEY `blog_comment_user_id_59a54155_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `blog_comment_article_id_3d58bca6_fk_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`nid`),
  CONSTRAINT `blog_comment_parent_comment_id_26791b9a_fk_blog_comment_nid` FOREIGN KEY (`parent_comment_id`) REFERENCES `blog_comment` (`nid`),
  CONSTRAINT `blog_comment_user_id_59a54155_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_comment
-- ----------------------------
INSERT INTO `blog_comment` VALUES ('85', '2018-08-31 17:16:02.744296', '1231231231231231', '1', null, '10');
INSERT INTO `blog_comment` VALUES ('86', '2018-08-31 17:16:09.361002', '柔柔弱弱若若若若若', '1', '85', '10');
INSERT INTO `blog_comment` VALUES ('87', '2018-09-02 16:32:02.512191', '123123123123', '1', null, '9');
INSERT INTO `blog_comment` VALUES ('88', '2018-09-02 16:32:11.453803', 'ddddddddddddd', '1', '87', '9');
INSERT INTO `blog_comment` VALUES ('89', '2018-09-02 16:33:51.633246', '12312312312', '1', '85', '9');
INSERT INTO `blog_comment` VALUES ('90', '2018-09-02 17:37:26.503060', 'rrrrrrrrrrrrrrrrrrr', '1', '86', '9');
INSERT INTO `blog_comment` VALUES ('91', '2018-09-02 18:01:02.848816', '123123123', '1', null, '9');
INSERT INTO `blog_comment` VALUES ('92', '2018-09-02 18:01:25.813711', '12312312312aaaa', '1', '91', '9');
INSERT INTO `blog_comment` VALUES ('93', '2018-09-05 16:37:40.661638', '00000000000000000', '1', null, '10');
INSERT INTO `blog_comment` VALUES ('94', '2018-09-05 16:38:14.483328', '噼噼啪啪铺铺铺铺铺铺铺铺铺铺', '1', null, '10');
INSERT INTO `blog_comment` VALUES ('96', '2018-09-14 22:45:10.298756', '45555555555555', '1', null, '10');
INSERT INTO `blog_comment` VALUES ('97', '2018-09-14 22:45:24.428032', 'bbbbbbbbbbbb', '1', null, '10');
INSERT INTO `blog_comment` VALUES ('99', '2018-09-15 09:49:35.708196', '3333333333333333333', '1', null, '13');
INSERT INTO `blog_comment` VALUES ('100', '2018-09-15 09:50:03.456951', '33333333333333', '5', null, '13');
INSERT INTO `blog_comment` VALUES ('101', '2018-09-15 17:38:00.170625', '12312312312', '7', null, '14');
INSERT INTO `blog_comment` VALUES ('102', '2018-09-15 21:17:41.039686', '5255555', '9', null, '14');
INSERT INTO `blog_comment` VALUES ('104', '2018-09-16 08:13:29.463631', '惺惺惜惺惺', '17', null, '9');
INSERT INTO `blog_comment` VALUES ('105', '2018-09-16 08:17:31.256819', '呃呃呃鹅鹅鹅鹅鹅鹅饿', '20', null, '13');
INSERT INTO `blog_comment` VALUES ('106', '2018-09-16 08:52:54.137009', 'rrr', '21', null, '15');
INSERT INTO `blog_comment` VALUES ('107', '2018-09-16 08:53:02.135052', 'qweqwe', '21', null, '15');
INSERT INTO `blog_comment` VALUES ('108', '2018-09-16 08:53:07.643982', 'qweqweqwe', '21', '107', '15');
INSERT INTO `blog_comment` VALUES ('109', '2018-09-16 10:27:57.835157', '哈哈哈哈哈', '1', null, '16');
INSERT INTO `blog_comment` VALUES ('110', '2018-09-16 10:28:07.374592', '嘎嘎嘎', '1', '99', '16');
INSERT INTO `blog_comment` VALUES ('111', '2018-09-16 10:30:03.423786', '12312312321', '22', null, '16');
INSERT INTO `blog_comment` VALUES ('112', '2018-09-16 10:30:13.435608', '444412312321第三方士大夫', '22', null, '16');
INSERT INTO `blog_comment` VALUES ('113', '2018-09-16 10:30:22.922588', '奥术大师大所群无', '22', null, '16');
INSERT INTO `blog_comment` VALUES ('114', '2018-09-16 10:31:17.486057', '柔柔弱弱若若若若若若', '22', null, '16');
INSERT INTO `blog_comment` VALUES ('115', '2018-09-16 10:31:25.179514', '哦哦哦阿善动', '22', null, '16');

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `blog_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_tag_blog_id_a8c60c42_fk_blog_blog_nid` (`blog_id`),
  CONSTRAINT `blog_tag_blog_id_a8c60c42_fk_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES ('1', '王宏伟web', '1');
INSERT INTO `blog_tag` VALUES ('2', '小辉辉web', '2');
INSERT INTO `blog_tag` VALUES ('3', '王宏伟其他', '1');
INSERT INTO `blog_tag` VALUES ('4', '小辉辉其他', '2');
INSERT INTO `blog_tag` VALUES ('5', '火影', '1');
INSERT INTO `blog_tag` VALUES ('6', '火影大侠', '1');
INSERT INTO `blog_tag` VALUES ('7', 'Pizza1', '4');
INSERT INTO `blog_tag` VALUES ('8', 'Pizza2', '4');
INSERT INTO `blog_tag` VALUES ('9', 'Pizza3', '4');
INSERT INTO `blog_tag` VALUES ('10', '火火火', '1');
INSERT INTO `blog_tag` VALUES ('11', '小小web', '5');
INSERT INTO `blog_tag` VALUES ('12', 'pizza666', '4');
INSERT INTO `blog_tag` VALUES ('13', 'www', '6');
INSERT INTO `blog_tag` VALUES ('14', '小雪雪', '7');

-- ----------------------------
-- Table structure for blog_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `blog_userinfo`;
CREATE TABLE `blog_userinfo` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `telephone` varchar(11) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `blog_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `telephone` (`telephone`),
  UNIQUE KEY `blog_id` (`blog_id`),
  CONSTRAINT `blog_userinfo_blog_id_aa34488f_fk_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_userinfo
-- ----------------------------
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$SvbeNM2OvQeh$quWJBjrbdTK+ENdfDrQI5DYZ4qVQB2NY5evN74HmSv0=', '2018-08-24 00:40:47.693893', '1', 'wanghw123', '', '', '', '1', '1', '2018-08-15 15:38:18.982538', '1', null, '2018-08-15 15:38:19.055342', 'avatar/default.png', null);
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$QSa0JFJBFjjQ$eEF5hc2LhXW1Di/a0v7F8Tw+z32tOYoFBe138hMi99o=', '2018-08-24 00:39:45.453579', '0', 'wanghw1234', '', '', 'wang@qq.co', '0', '1', '2018-08-18 13:03:34.117125', '5', null, '2018-08-18 13:03:34.281684', 'avatars/default.jpg', null);
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$xee1v7RLExqG$/N4rYGKWEXsWDqU8dcwyl2SooBwEd6TPZNugMakKf98=', '2018-09-16 13:42:23.661150', '1', 'wanghw', '', '', '', '1', '1', '2018-08-24 00:45:42.000000', '9', '11111111111', '2018-08-24 00:45:42.748332', 'avatars/222.jpg', '1');
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$UVbxbX3x6iW7$iVk/oWTnur2SXpRzUuVxDlXgmNXl5iureBMJHaIYl4U=', '2018-09-14 22:43:52.837645', '1', 'jiaoxuhui', '', '', '', '1', '1', '2018-08-24 00:46:16.000000', '10', '22222222222', '2018-08-24 00:46:16.249898', 'avatars/default.jpg', '2');
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$d8gNhhNEGNXj$lkXzM7l5/b94FNysK5gfbnQQ6GkfiTNXj+h/PwAQ6LI=', '2018-08-28 19:59:26.385238', '0', 'wanghw11', '', '', '123123123@qq.com', '0', '1', '2018-08-28 19:57:57.788791', '11', null, '2018-08-28 19:57:57.876506', 'avatars/11111.jpg', null);
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$IkfReOJEQp9b$A2hPB5H3GQo6n6ne1f/0VSV9ORbuTXVu+Fd7SmstAzs=', '2018-09-16 09:19:15.398577', '0', 'pizza', '', '', 'pizza@123.com', '0', '1', '2018-09-15 09:37:11.052658', '13', null, '2018-09-15 09:37:11.231410', 'avatars/11111_BsfvqkF.jpg', '4');
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$Q7Ou9w31MEkE$agPRhrk2z5JQIR9NdjwXWaGSr34vAjk6ocVNqd09qcU=', '2018-09-15 17:36:28.268762', '0', 'xiaoxiao', '', '', '123@qa.com', '0', '1', '2018-09-15 17:33:35.509866', '14', null, '2018-09-15 17:33:35.579680', 'avatars/微信图片_20180312195453_3zIuSgc.jpg', '5');
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$rAJiEAlZlCb0$0MbuMIB66aFKLbIm00lFIAtsmVGgYilv/gI7fsvY7VA=', '2018-09-16 08:18:46.671902', '0', 'bigger', '', '', '123@112.com', '0', '1', '2018-09-16 08:18:29.529454', '15', null, '2018-09-16 08:18:29.609277', 'avatars/微信图片_20180312195453_pfAkUfh.jpg', '6');
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$Bsw80lLHwlGQ$2RUvSLNawoumRvM4fULEv2zf57297I8qRhyCi2zZtQk=', '2018-09-16 10:27:26.079666', '0', 'xuexue', '', '', 'eee@qq.com', '0', '1', '2018-09-16 10:27:10.283871', '16', null, '2018-09-16 10:27:10.384602', 'avatars/微信图片_20180312195453_rl9osTC.jpg', '7');

-- ----------------------------
-- Table structure for blog_userinfo_groups
-- ----------------------------
DROP TABLE IF EXISTS `blog_userinfo_groups`;
CREATE TABLE `blog_userinfo_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_userinfo_groups_userinfo_id_group_id_5f60ecec_uniq` (`userinfo_id`,`group_id`),
  KEY `blog_userinfo_groups_group_id_1fb5e93a_fk_auth_group_id` (`group_id`),
  CONSTRAINT `blog_userinfo_groups_group_id_1fb5e93a_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `blog_userinfo_groups_userinfo_id_f6f0498b_fk_blog_userinfo_nid` FOREIGN KEY (`userinfo_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_userinfo_groups
-- ----------------------------

-- ----------------------------
-- Table structure for blog_userinfo_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `blog_userinfo_user_permissions`;
CREATE TABLE `blog_userinfo_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_userinfo_user_permi_userinfo_id_permission_i_7d343093_uniq` (`userinfo_id`,`permission_id`),
  KEY `blog_userinfo_user_p_permission_id_ace80f7e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `blog_userinfo_user_p_permission_id_ace80f7e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `blog_userinfo_user_p_userinfo_id_57e76697_fk_blog_user` FOREIGN KEY (`userinfo_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_userinfo_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2018-08-24 00:51:24.167479', '1', '木叶忍者村', '1', '[{\"added\": {}}]', '10', '9');
INSERT INTO `django_admin_log` VALUES ('2', '2018-08-24 00:51:58.321213', '2', '异乡异客', '1', '[{\"added\": {}}]', '10', '9');
INSERT INTO `django_admin_log` VALUES ('3', '2018-08-24 00:52:46.873287', '9', 'wanghw', '2', '[{\"changed\": {\"fields\": [\"telephone\", \"blog\"]}}]', '6', '9');
INSERT INTO `django_admin_log` VALUES ('4', '2018-08-24 00:53:01.615623', '10', 'jiaoxuhui', '2', '[{\"changed\": {\"fields\": [\"telephone\", \"blog\"]}}]', '6', '9');
INSERT INTO `django_admin_log` VALUES ('5', '2018-08-24 00:55:27.805751', '1', 'whw的文章', '1', '[{\"added\": {}}]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('6', '2018-08-24 00:55:45.563531', '2', 'xuhui\'s 文章', '1', '[{\"added\": {}}]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('7', '2018-08-24 00:57:14.135605', '1', '我是怎么把一个项目带崩的', '1', '[{\"added\": {}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('8', '2018-08-24 00:58:03.572385', '2', 'Linux的内存分页管理', '1', '[{\"added\": {}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('9', '2018-08-24 00:59:03.218362', '3', 'wanghw\'s web', '1', '[{\"added\": {}}]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('10', '2018-08-24 00:59:14.759287', '4', 'jiao\'s web', '1', '[{\"added\": {}}]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('11', '2018-08-24 01:00:14.669559', '3', '藏在正则表达式里的陷阱', '1', '[{\"added\": {}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('12', '2018-08-24 01:00:52.919717', '4', '从 docker 到 runC', '1', '[{\"added\": {}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('13', '2018-08-24 01:01:34.270274', '5', '.net环境下跨进程、高频率读写数据', '1', '[{\"added\": {}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('14', '2018-08-24 03:35:31.992915', '1', '王宏伟web', '1', '[{\"added\": {}}]', '13', '9');
INSERT INTO `django_admin_log` VALUES ('15', '2018-08-24 03:35:43.426224', '2', '小辉辉web', '1', '[{\"added\": {}}]', '13', '9');
INSERT INTO `django_admin_log` VALUES ('16', '2018-08-24 03:35:59.375034', '5', '.net环境下跨进程、高频率读写数据', '2', '[]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('17', '2018-08-24 03:37:35.833077', '1', '从 docker 到 runC——王宏伟web', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('18', '2018-08-24 03:38:19.433302', '1', '从 docker 到 runC——小辉辉web', '2', '[{\"changed\": {\"fields\": [\"tag\"]}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('19', '2018-08-24 03:38:28.293505', '2', '我是怎么把一个项目带崩的——王宏伟web', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('20', '2018-08-24 03:39:12.128911', '3', '王宏伟其他', '1', '[{\"added\": {}}]', '13', '9');
INSERT INTO `django_admin_log` VALUES ('21', '2018-08-24 03:39:22.937203', '4', '小辉辉其他', '1', '[{\"added\": {}}]', '13', '9');
INSERT INTO `django_admin_log` VALUES ('22', '2018-08-24 03:39:54.654870', '3', 'Linux的内存分页管理——王宏伟其他', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('23', '2018-08-24 03:40:10.363745', '4', '藏在正则表达式里的陷阱——小辉辉其他', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('24', '2018-08-24 03:40:23.027845', '5', '从 docker 到 runC——小辉辉其他', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('25', '2018-08-24 03:40:32.885098', '6', '.net环境下跨进程、高频率读写数据——王宏伟web', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('26', '2018-08-24 04:04:14.765861', '1', '从 docker 到 runC——小辉辉web', '3', '', '8', '9');
INSERT INTO `django_admin_log` VALUES ('27', '2018-08-24 04:04:50.819696', '5', '从 docker 到 runC——小辉辉其他', '3', '', '8', '9');
INSERT INTO `django_admin_log` VALUES ('28', '2018-08-24 04:05:06.177410', '7', '从 docker 到 runC——小辉辉web', '1', '[{\"added\": {}}]', '8', '9');
INSERT INTO `django_admin_log` VALUES ('29', '2018-08-24 09:39:50.190762', '3', 'wanghw_web', '2', '[{\"changed\": {\"fields\": [\"title\"]}}]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('30', '2018-08-24 09:39:59.947816', '4', 'jiao_web', '2', '[{\"changed\": {\"fields\": [\"title\"]}}]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('31', '2018-08-24 18:03:35.727825', '3', 'wanghw_web', '2', '[]', '11', '9');
INSERT INTO `django_admin_log` VALUES ('32', '2018-08-25 10:14:41.823285', '5', '.net环境下跨进程、高频率读写数据', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('33', '2018-08-25 10:19:00.987959', '4', '从 docker 到 runC', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '7', '9');
INSERT INTO `django_admin_log` VALUES ('34', '2018-08-25 10:45:49.650293', '4', '从 docker 到 runC', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '7', '9');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('7', 'blog', 'article');
INSERT INTO `django_content_type` VALUES ('8', 'blog', 'article2tag');
INSERT INTO `django_content_type` VALUES ('9', 'blog', 'articleupdown');
INSERT INTO `django_content_type` VALUES ('10', 'blog', 'blog');
INSERT INTO `django_content_type` VALUES ('11', 'blog', 'category');
INSERT INTO `django_content_type` VALUES ('12', 'blog', 'comment');
INSERT INTO `django_content_type` VALUES ('13', 'blog', 'tag');
INSERT INTO `django_content_type` VALUES ('6', 'blog', 'userinfo');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-08-15 15:36:44.743277');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2018-08-15 15:36:44.820054');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2018-08-15 15:36:45.178051');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2018-08-15 15:36:45.227918');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2018-08-15 15:36:45.236894');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2018-08-15 15:36:45.245870');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2018-08-15 15:36:45.254884');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2018-08-15 15:36:45.260829');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2018-08-15 15:36:45.269806');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2018-08-15 15:36:45.278791');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0009_alter_user_last_name_max_length', '2018-08-15 15:36:45.286759');
INSERT INTO `django_migrations` VALUES ('12', 'blog', '0001_initial', '2018-08-15 15:36:47.106230');
INSERT INTO `django_migrations` VALUES ('13', 'admin', '0001_initial', '2018-08-15 15:36:47.314190');
INSERT INTO `django_migrations` VALUES ('14', 'admin', '0002_logentry_remove_auto_add', '2018-08-15 15:36:47.333139');
INSERT INTO `django_migrations` VALUES ('15', 'sessions', '0001_initial', '2018-08-15 15:36:47.417912');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('4d98bkdr1omp460y40i1yone7posz95m', 'YjlhNTM0YTgyM2FiYWYwMmZhY2QxMDE1OTdlMzc3ODYyNWQ4NDY2Njp7Il9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjM2FiMTBiYjNlZGUxMjM3OTdhMWMwZGJkMTUyYmJjNzhkZDMzNGRkIiwidmFsaWRfY29kZV9zdHIiOiIyMmZLdCJ9', '2018-09-11 10:23:59.465839');
INSERT INTO `django_session` VALUES ('5g8jtfjvf65owoaz8gxcxeg3k15ks1ls', 'ZDA4YzBkN2RhM2Y2M2I1ODM1MTFjYzdmNzYyM2FiNjY2NTNlNDY0MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhN2VmN2NiMjNlNzYzNTdhNzNlY2JkOTVhMWYxOTZkYzlhMTA2NDU0IiwidmFsaWRfY29kZV9zdHIiOiJwYVo3ZyJ9', '2018-09-05 13:32:27.095793');
INSERT INTO `django_session` VALUES ('5z8odet3e6b2u0hv34shsp9n5podhmc5', 'NDExZTQ5MDc5NWRkZjI4MDA0ZTQ4MjFmMTRhNmUzMWY0Mzk4YTQ5ODp7InZhbGlkX2NvZGVfc3RyIjoiR1o0MFMiLCJfYXV0aF91c2VyX2lkIjoiNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTlhZTEwYWUyMmFjNDM4YTZjMTMwNTliYzhjZDJiYTE3NzdmZWFiOCJ9', '2018-09-07 00:39:45.457626');
INSERT INTO `django_session` VALUES ('64iupk7aztue8xs5yc7ttpderdr1lrov', 'NGY3Y2FmNjc4NWNiYWJmMGQ2MDdlMDZmYjJhOWQwYTVmYTFhM2Q1OTp7InZhbGlkX2NvZGVfc3RyIjoiMGJqMGoifQ==', '2018-09-30 13:43:45.488962');
INSERT INTO `django_session` VALUES ('8i19ns2o7f1v9z0wjdm4gzr2ajyvmped', 'ZDBlYmFmNTk2NTFjN2RlZGI3ZTViOGFlNTJjYTZhYzlhOTk1ZTAzZTp7InZhbGlkX2NvZGVfc3RyIjoiMHh6aXAiLCJfYXV0aF91c2VyX2lkIjoiOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzNhYjEwYmIzZWRlMTIzNzk3YTFjMGRiZDE1MmJiYzc4ZGQzMzRkZCJ9', '2018-09-29 17:01:10.177029');
INSERT INTO `django_session` VALUES ('b33znu10jqttkyq65bhw2szix42nqaot', 'ZjY4MTdlODUyNWQ4ZWYxNTRiOTU2ZGE0ODY3YTRjOTEzYzgxYjhhMzp7InZhbGlkX2NvZGVfc3RyIjoiejdnUkwiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTdlZjdjYjIzZTc2MzU3YTczZWNiZDk1YTFmMTk2ZGM5YTEwNjQ1NCJ9', '2018-08-31 03:14:57.555179');
INSERT INTO `django_session` VALUES ('dbvw1dpaebx928dnlahkt84ku1e9dobt', 'YzdlNDI3MzY5ZWQwM2IwMjIzOTNjOGZiYjQzOTk4Zjg4ZDFlMjJmYzp7InZhbGlkX2NvZGVfc3RyIjoiVWNkSUUiLCJfYXV0aF91c2VyX2lkIjoiMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjJjYzU5ZmI4NzkxN2E5OTUxOTEwMmNjZDRhZjgxOWQwYmJkMDg4YTcifQ==', '2018-09-09 09:02:57.848123');
INSERT INTO `django_session` VALUES ('nm064rc9p638t2bdj9vh5hq1trr9pjh7', 'Y2IwNWRiMzAwYjAyZjIzZjhmYjNlYWI5ODgzMDJkYzY2OTYwMzk5MTp7InZhbGlkX2NvZGVfc3RyIjoiSzU2Z00iLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTdlZjdjYjIzZTc2MzU3YTczZWNiZDk1YTFmMTk2ZGM5YTEwNjQ1NCJ9', '2018-09-06 02:18:58.348373');
INSERT INTO `django_session` VALUES ('t5s3kjzp9pfc8z5wmwqiwac7crhjd3wa', 'ODJkZWMxMzgxNDFiNjYxOTQ2YTI2NDFkNzVmZDUxM2E3Yjk0Mjk4OTp7InZhbGlkX2NvZGVfc3RyIjoiWENwdmQiLCJfYXV0aF91c2VyX2lkIjoiMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjJjYzU5ZmI4NzkxN2E5OTUxOTEwMmNjZDRhZjgxOWQwYmJkMDg4YTcifQ==', '2018-09-07 20:25:12.874061');
INSERT INTO `django_session` VALUES ('ublyx2wfrydvbowi2xcvxvh42ykkq2ng', 'ZTRlZTY1NzU3YzE2MTA2YTE5MjA3ZjA1ZTNjOTcwYjdlZmQxYmEzNjp7InZhbGlkX2NvZGVfc3RyIjoiRjJ4OXQiLCJfYXV0aF91c2VyX2lkIjoiMTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjBlZDY3MWM1MGFiN2Q2NjQ0NTZmOGI3NjZiODE3YTllODNjMzYxM2MifQ==', '2018-09-29 08:19:22.636149');
INSERT INTO `django_session` VALUES ('umwxg1e3hq53riknuj5adwsxy44db35r', 'YTczYTRhMDJhNjFhZDY0OWNmMzY4NjlkOTdhMTIwNDBjNWFhODRkZjp7InZhbGlkX2NvZGVfc3RyIjoiNzN6aTQifQ==', '2018-09-14 14:47:35.826568');
INSERT INTO `django_session` VALUES ('z7ww69t9wwh9fv48xyv33t3bowo0c7jj', 'NjQ5M2E4YTZkNzFlNDY3YmY4Y2Y4MzY0MWY4OWY0MDY1ZjZiNDYxMzp7InZhbGlkX2NvZGVfc3RyIjoiNTl2MVciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTdlZjdjYjIzZTc2MzU3YTczZWNiZDk1YTFmMTk2ZGM5YTEwNjQ1NCJ9', '2018-08-30 01:39:56.885644');
