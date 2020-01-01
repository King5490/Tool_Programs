#!/usr/bin/env python
# -*-coding:utf-8-*-
# author:King time:2020/1/1
import os
import re


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
            all_files.extend([file])
            if re.search('特征正则表达式1', file)and re.search('特征正则表达式2', file):
                file_name = os.path.join(root, '"' + file + '"')
                all_files.extend([file_name])
                command = 'move ' + file_name + ' ' + path + '/挑选结果'
                if os.system(command):
                    print('\n' + file_name + ' 此文件移动失败(可能为隐藏文件)')
                    failed_num += 1
                target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) + '个特征文件,' + ' 其中失败了' + str(failed_num) + '文件.')


files_filter()
os.system("pause")
