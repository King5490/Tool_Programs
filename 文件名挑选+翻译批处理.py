#!/usr/bin/env python
# -*-coding:utf-8-*-
# author:King time:2020/1/1
import os
import re
from googletrans import Translator

# os.system()是直接操作的CMD(注意使用CMD语法)
# subprocessd调用powershell脚本的方式可以使用shell(还不如直接shell脚本方便)
# googletrans翻译模块是利用的Google翻译,需要网络支持,官方文档:
# https://py-googletrans.readthedocs.io/en/latest/

translator = Translator()


def files_filter():
    all_files = []
    target_num = 0
    failed_num = 0
    path = os.getcwd()
    all_path = os.walk(path)

    folder = os.path.exists(path + '/挑选结果')
    if not folder:
        os.mkdir('挑选结果')

    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)
            all_files.extend([file])

            if re.search('特征正则表达式1', file) and re.search('特征正则表达式2', file):
                command = 'move "' + file_name + '" "' + path + '/挑选结果"'
                if os.system(command):
                    print('\n' + file_name + ' 此文件移动失败(可能为隐藏文件)')
                    failed_num += 1
                target_num += 1

            # 本处为自动鉴别语言,进行文件名英译中,可替换任意语言互译(相关语言简写见上文官方文档)
            elif translator.detect(file).lang == 'jw':
                point_before = file[0:file.find('.')]
                point_after = file[file.find('.'):len(file)]
                file_rename = translator.translate(point_before, dest='zh-CN').text
                command_r = 'ren "' + file_name + '" "' + file_rename + point_after + '"'
                os.system(command_r)

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件, 其中失败了' + str(failed_num) + '文件.')


files_filter()
os.system("pause")
