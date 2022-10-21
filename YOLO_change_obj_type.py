#!/usr/bin/env python3
# -*-coding:utf-8-*-
# Author: King
# Date: 2022/10/15
# Last Modified by: 24677
# Last Modified time: 星期六 15:49
import re
import os


# YOLO 类别批量更改

def main():
    path = os.getcwd()

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)
            if not re.search('py', file):
                file_path = file_name
                txt_file = open(file_path, 'r+')
                # 需要读取并写入，
                contents = txt_file.readline()
                # 读取文本内容之后文件指针会置于文件的最后

                pattern1 = re.compile(r'^[1-6]')
                if re.search(pattern1, contents):
                    txt_file.seek(0, 0)
                    # 调文件指针文件最开始，后面才能覆写文件
                    # pattern = re.compile(r'(?<=\[\')[1-6]')
                    pattern2 = re.compile(r'\n')
                    # compile内的r为输入正则标志符，本行语句为去除读入的换行符
                    new_contents = re.sub(pattern1, '0', contents)
                    new_contents = re.sub(pattern2, '', new_contents)
                    # re.sub自动替换文本信息
                    txt_file.write(new_contents)

                txt_file.close()
                # 写入文件后记得关闭文件类


if __name__ == '__main__':
    main()
