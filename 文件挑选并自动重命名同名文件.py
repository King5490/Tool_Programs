#!/usr/bin/env python
# -*-coding:utf-8-*-
# author:King time:2020/1/1
import os
import re


def files_filter():
    all_files = []
    target_num = 0
    failed_num = 0
    SameName_num = 0
    path = os.getcwd()

    folder = os.path.exists(path + '/挑选结果')
    if not folder:
        os.mkdir('挑选结果')

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            all_files.extend([file])

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)

            if not re.search('挑选结果', root):
                if re.search('mp4', file) or re.search('mov', file) or re.search('mkv', file):
                    if all_files.count(file) >= 2:
                        point_before = file[0:file.find('.')]
                        point_after = file[file.find('.'):len(file)]
                        file_rename = point_before + '_' + str(SameName_num) + point_after
                        SameName_num += 1
                        command_r = 'ren "' + file_name + '" "' + file_rename + '"'
                        os.system(command_r)
                        file_name = os.path.join(root, file_rename)

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/挑选结果' + '"'
                    if os.system(command):
                        os.system(command)
                        print('\n' + file_name + ' 此文件移动失败(可能为隐藏文件)')
                        failed_num += 1
                    target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')


files_filter()
os.system("pause")
