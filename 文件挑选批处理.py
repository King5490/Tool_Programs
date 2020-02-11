#!/usr/bin/env python
# -*-coding:utf-8-*-
# author:King time:2020/2/11
import os
import re
from googletrans import Translator

# os.system()是直接操作的CMD(注意使用CMD语法)
# subprocessd调用powershell脚本的方式可以使用shell(还不如直接shell脚本方便)
# googletrans翻译模块是利用的Google翻译,需要网络支持,官方文档:
# https://py-googletrans.readthedocs.io/en/latest/

def audio_extractor(all_files, path):
    target_num = 0
    failed_num = 0
    SameName_num = 0
    translator = Translator()

    folder = os.path.exists(path + '/挑选结果')
    if not folder:
        os.mkdir('挑选结果')

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)

            if not re.search('挑选结果', root) and not re.search('所有文件', root):
                if re.search('正则表达式1', file) and re.search('正则表达式2', file) and not re.search('正则表达式3', file):

                    if all_files.count(file) >= 2:
                        point_before = os.path.splitext(file)[0]
                        point_after = os.path.splitext(file)[-1]
                        file_rename = point_before + '_' + str(SameName_num) + point_after
                        SameName_num += 1
                        command_r = 'ren "' + file_name + '" "' + file_rename + '"'
                        os.system(command_r)
                        file_name = os.path.join(root, file_rename)

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/挑选结果' + '"'
                    try:
                        os.system(command)
                    except EnvironmentError:
                        print('\n' + file_name + ' 此文件移动失败(可能为隐藏文件)')
                        failed_num += 1
                    target_num += 1

                # 为了防止误操作,以下将语言检测设置为爪哇语
                elif translator.detect(file).lang == 'jw':
                    point_before = os.path.splitext(file)[0]
                    point_after = os.path.splitext(file)[-1]
                    file_rename = translator.translate(point_before, dest='zh-CN').text
                    command_r = 'ren "' + file_name + '" "' + file_rename + point_after + '"'
                    os.system(command_r)

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件筛选类型:"))


def video_extractor(all_files, path):
    target_num = 0
    failed_num = 0
    SameName_num = 0

    folder = os.path.exists(path + '/挑选结果')
    if not folder:
        os.mkdir('挑选结果')

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)

            if not re.search('挑选结果', root) and not re.search('所有文件', root):
                if re.search('mp4', file, re.I) or re.search('mov', file, re.I) or re.search('mkv', file, re.I):

                    if all_files.count(file) >= 2:
                        point_before = os.path.splitext(file)[0]
                        point_after = os.path.splitext(file)[-1]
                        file_rename = point_before + '_' + str(SameName_num) + point_after
                        SameName_num += 1
                        command_r = 'ren "' + file_name + '" "' + file_rename + '"'
                        os.system(command_r)
                        file_name = os.path.join(root, file_rename)

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/挑选结果' + '"'
                    try:
                        os.system(command)
                    except EnvironmentError:
                        print('\n' + file_name + ' 此文件移动失败(可能为隐藏文件)')
                        failed_num += 1
                    target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件筛选类型:"))


def all_files_extractor(all_files, path):
    target_num = 0
    failed_num = 0
    SameName_num = 0

    folder = os.path.exists(path + '/所有文件')
    if not folder:
        os.mkdir('所有文件')

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)

            if not re.search('挑选结果', root) and not re.search('所有文件', root):
                if not re.search('txt', file, re.I) and not re.search('url', file, re.I) and not re.search('py', file,
                                                                                                         re.I):

                    if all_files.count(file) >= 2:
                        point_before = os.path.splitext(file)[0]
                        point_after = os.path.splitext(file)[-1]
                        file_rename = point_before + '_' + str(SameName_num) + point_after
                        SameName_num += 1
                        command_r = 'ren "' + file_name + '" "' + file_rename + '"'
                        os.system(command_r)
                        file_name = os.path.join(root, file_rename)

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/所有文件' + '"'
                    try:
                        os.system(command)
                    except EnvironmentError:
                        print('\n' + file_name + ' 此文件移动失败(可能为隐藏文件)')
                        failed_num += 1
                    target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件筛选类型:"))


def files_filter(model):
    all_files = []
    path = os.getcwd()

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            all_files.extend([file])

    if model == '1':
        audio_extractor(all_files, path)
    elif model == '2':
        video_extractor(all_files, path)
    elif model == '3':
        all_files_extractor(all_files, path)
    else:
        os.system("pause")


print('输入类型: 1 为音频筛选; 2 为视频筛选; 3 为文件全提取(除之前的视频与音频外)\n输入其他为退出\n')
files_filter(model=input("请输入文件筛选类型:"))
