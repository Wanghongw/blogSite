import random

##获取三个随机数，用于“颜色的调配”
def get_random_color():
    return (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))

def get_valid_code_img(request):
    ###基于PIL模块动态生成状态码图片
    ##引入相应模块
    from PIL import Image, ImageDraw, ImageFont
    from io import BytesIO

    ##这个大小跟前端的img大小要一致
    img = Image.new('RGB', (260, 35), color=get_random_color())
    draw = ImageDraw.Draw(img)
    ##字体对象，字体大小为32
    font_obj = ImageFont.truetype('static/font/bmwy.ttf', size=28)

    ##随机获取5位的数字字母的组合
    valid_code_str = ''
    for i in range(5):
        random_num = str(random.randint(0, 9))
        random_low_alpha = chr(random.randint(97, 122))
        random_upper_alpha = chr(random.randint(65, 90))
        random_char = random.choice([random_num, random_upper_alpha, random_low_alpha])
        draw.text((i * 50 + 20, 5), random_char, get_random_color(), font=font_obj)
        ##保存验证码字符串
        valid_code_str += random_char

    ##噪点噪线
    width = 260
    height = 35
    for i in range(1):
        x1 = random.randint(10,width)
        x2 = random.randint(10,width)
        y1 = random.randint(10,height)
        y2 = random.randint(10,height)
        draw.line((x1,x2,y1,y2),fill=get_random_color())
    for i in range(3):
        draw.point([random.randint(0,width),random.randint(0,height)],fill=get_random_color())
        x = random.randint(0,width)
        y = random.randint(0,height)
        draw.arc((x,y,x+14,y+14),0,90,fill=get_random_color())

    print('valid_code_str', valid_code_str)
    ##将随机字符串存在session里——再在login()中提取！
    ##这部分十分重要！要知道三个详细的流程
    request.session['valid_code_str'] = valid_code_str
    f = BytesIO()
    img.save(f, 'png')
    data = f.getvalue()
    return data