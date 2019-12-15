from django import forms
from django.forms import widgets
from blog.models import *
from django.core.exceptions import NON_FIELD_ERRORS,ValidationError
from blog.utils import check

class UserForm(forms.Form):
    user = forms.CharField(min_length=4,max_length=32,label='用户名',widget=widgets.TextInput(attrs={'class':'form-control'},),
                           error_messages={'required':'输入不能为空','min_length':'用户名最少4位'}
                           )

    pwd = forms.CharField(min_length=6,max_length=32,label='密码',widget=widgets.PasswordInput(attrs={'class':'form-control'},),
                          error_messages={'required':'输入不能为空','min_length':'密码最少6位'}
                          )

    re_pwd = forms.CharField(min_length=6,max_length=32,label='确认密码',widget=widgets.PasswordInput(attrs={'class':'form-control'},),
                             error_messages={'required':'输入不能为空','min_length':'密码最少6位'}
                             )

    email = forms.EmailField(max_length=32,label='邮箱',widget=widgets.EmailInput(attrs={'class':'form-control'},),
                             error_messages={'required':'输入不能为空','invalid':'邮箱格式不正确'}
                             )
    ##局部钩子
    ##校验数据库中是否有相同的用户名，注意这个user是上面定义的属性名
    ##用户名不能为纯数字
    ##用户名不能包含汉字
    def clean_user(self):
        val = self.cleaned_data.get('user')
        # print(val)
        c = check.check_contain_chinese(val)
        if c:
            raise ValidationError('用户名不能包含汉字')
        #数据库中检测
        ret = UserInfo.objects.filter(username=val).first()
        if str(val).isdigit():
            raise ValidationError('用户名不能为纯数字')
        elif ret:
            raise ValidationError('该用户已注册')
        else:
            return val
    ##校验邮箱不能重复
    def clean_email(self):
        email = self.cleaned_data.get('email')
        ret = UserInfo.objects.filter(email=email).first()
        if ret:
            raise ValidationError('该邮箱已注册')
        else:
            return email
    ##全局钩子——通过__all__获取
    ##注意全局钩子可以在视图中获取，也可以直接在模板中获取——本次在模板中直接获取
    ##视图中： full_errors = form.errors.get('__all__')
    ##模板中：if(foo === '__all__')......
    def clean(self):
        pwd = self.cleaned_data.get('pwd')
        re_pwd = self.cleaned_data.get('re_pwd')
        if pwd and re_pwd:
            if pwd == re_pwd:
                return self.cleaned_data
            else:
                raise ValidationError('两次密码不一致')
        else:
            return self.cleaned_data
