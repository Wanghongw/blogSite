##判断一个字符串中是否有汉字
def check_contain_chinese(check_str):
    for ch in check_str:
        if ch >= '\u4e00' and ch <= '\u9fff':
            return True
        else:continue
if __name__ == '__main__':
    print(check_contain_chinese('123'))
    print(check_contain_chinese('zxdasd123'))
    print(check_contain_chinese('12asd哈哈qwe'))