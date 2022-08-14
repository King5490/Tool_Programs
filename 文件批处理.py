#!/usr/bin/env python
# -*-coding:utf-8-*-
# author:King time:2020/2/11
import os
import re
import win32con
import win32api
from googletrans import Translator

# os.system()是直接操作的CMD(注意使用CMD语法)
# shutil模块(高级文件操作模块)可替换一些CMD指令
# pywin32中的函数可替换本文的cmd指令，但是会检验每一个文件是否隐藏
# pathlib可用于替换本程序中的os.path指令
# subprocessd调用powershell脚本的方式可以使用shell(还不如直接shell脚本方便)
# googletrans翻译模块是利用的Google翻译,需要网络支持,官方文档:
# https://py-googletrans.readthedocs.io/en/latest/


def audio_extractor(all_files, path):
    target_num = 0
    failed_num = 0
    SameName_num = 0
    translator = Translator()

    folder = os.path.exists(path + '/音频挑选结果')
    if not folder:
        os.mkdir('音频挑选结果')

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

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/音频挑选结果' + '"'
                    if os.system(command):
                        if win32api.GetFileAttributes(file_name.replace('\\', '/')) & 2:
                            win32api.SetFileAttributes(file_name.replace('\\', '/'), win32con.FILE_ATTRIBUTE_ARCHIVE)
                        if os.system(command):
                            print('\n' + file_name + ' 此文件移动失败')
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
    files_filter(model=input("请输入文件批处理类型:"))


def video_extractor(all_files, path):
    target_num = 0
    failed_num = 0
    SameName_num = 0

    folder = os.path.exists(path + '/视频挑选结果')
    if not folder:
        os.mkdir('视频挑选结果')

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

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/视频挑选结果' + '"'
                    if os.system(command):
                        if win32api.GetFileAttributes(file_name.replace('\\', '/')) & 2:
                            win32api.SetFileAttributes(file_name.replace('\\', '/'), win32con.FILE_ATTRIBUTE_ARCHIVE)
                        if os.system(command):
                            print('\n' + file_name + ' 此文件移动失败')
                            failed_num += 1
                    target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件批处理类型:"))


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
                    if os.system(command):
                        if win32api.GetFileAttributes(file_name.replace('\\', '/')) & 2:
                            win32api.SetFileAttributes(file_name.replace('\\', '/'), win32con.FILE_ATTRIBUTE_ARCHIVE)
                        if os.system(command):
                            print('\n' + file_name + ' 此文件移动失败')
                            failed_num += 1
                    target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件批处理类型:"))


def delete_all_empty_folder(path):
    all_path = os.walk(path, topdown=False)
    # Python中的os.walk提供了一种从内到外的遍历目录树的方法（设置topdown = False）
    # 这样由内到外判断当前目录树下是否有文件和文件夹，如果都没有则意味着当前目录树为空文件夹，os.rmdir删除即可
    for root, dirs, files in all_path:
        # 先删除空白文件
        for file in files:
            file_name = os.path.join(root, file)
            if os.path.isfile(file_name):  # 如果是文件
                if os.path.getsize(file_name) == 0 or re.search('url', file, re.I):  # 文件大小为0或者为网址链接
                    os.remove(file_name)  # 删除这个文件
        # 删除空白文件夹
        if not os.listdir(root):
            os.rmdir(root)

    print('空白文件夹和空白文件已全部删除！\n')
    files_filter(model=input("请输入文件批处理类型:"))


def file_delete(all_files, path):
    target_num = 0
    failed_num = 0

    target_format = input("请输入需要删除的文件格式:")
    if target_format == '':
        target_format = 'NULL'

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)

            if not re.search('挑选结果', root) and not re.search('所有文件', root):
                if re.search(target_format, file, re.I) and not re.search('py', file, re.I):
                    command = 'del ' + '"' + file_name + '"'
                    if os.system(command):
                        if win32api.GetFileAttributes(file_name.replace('\\', '/')) & 2:
                            win32api.SetFileAttributes(file_name.replace('\\', '/'), win32con.FILE_ATTRIBUTE_ARCHIVE)
                        if os.system(command):
                            print('\n' + file_name + ' 此文件删除失败')
                            failed_num += 1
                    target_num += 1

    all_path = os.walk(path, topdown=False)
    for root, dirs, files in all_path:
        # 删除空白文件夹
        if not os.listdir(root):
            os.rmdir(root)

    print('从' + str(len(all_files)) + '个文件中删除了' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件批处理类型:"))


def file_extractor(all_files, path):
    target_num = 0
    failed_num = 0
    SameName_num = 0

    target_format = input("请输入需要挑选的文件格式:")
    if target_format == '':
        target_format = 'NULL'

    folder = os.path.exists(path + '/' + target_format + '挑选结果')
    if not folder:
        os.mkdir(target_format + '挑选结果')

    all_path = os.walk(path)
    for root, dirs, files in all_path:
        for file in files:
            file_name = os.path.join(root, file)

            if not re.search('挑选结果', root) and not re.search('所有文件', root):
                if re.search(target_format, file, re.I) and not re.search('py', file, re.I):

                    if all_files.count(file) >= 2:
                        point_before = os.path.splitext(file)[0]
                        point_after = os.path.splitext(file)[-1]
                        file_rename = point_before + '_' + str(SameName_num) + point_after
                        SameName_num += 1
                        command_r = 'ren "' + file_name + '" "' + file_rename + '"'
                        os.system(command_r)
                        file_name = os.path.join(root, file_rename)

                    command = 'move ' + '"' + file_name + '"' + ' ' + '"' + path + '/' + target_format + '挑选结果' + '"'
                    if os.system(command):
                        if win32api.GetFileAttributes(file_name.replace('\\', '/')) & 2:
                            win32api.SetFileAttributes(file_name.replace('\\', '/'), win32con.FILE_ATTRIBUTE_ARCHIVE)
                        if os.system(command):
                            print('\n' + file_name + ' 此文件移动失败')
                            failed_num += 1
                    target_num += 1

    print('从' + str(len(all_files)) + '个文件中挑选' + str(target_num) +
          '个特征文件,' + '其中失败了' + str(failed_num) + '文件.')
    files_filter(model=input("请输入文件批处理类型:"))


def delete_selected_folder(path):
    import ctypes
    import sys

    if sys.version_info[0] == 3:
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)
    else:  # in python2.x
        ctypes.windll.shell32.ShellExecuteW(None, u"runas", unicode(sys.executable), unicode(__file__), None, 1)

    selected_folder = input('请输入当前目录下你想删除的文件夹名称（注意区分大小写）:')
    command = 'rd /s/q "' + path + '/' + selected_folder + '"'

    if not os.system(command):  # 指令运行成功的话返回为0
        print('\n' + selected_folder + ' 文件夹删除成功')
    else:
        print('\n' + selected_folder + ' 文件夹删除失败')

    files_filter(model=input("请输入文件批处理类型:"))


def delete_all_folder(path):
    confirm = input('你真的想删除当前目录下的所有文件夹吗？（请输入 Yes 进行确认）:')
    if confirm == 'Yes':
        import ctypes
        import sys

        if sys.version_info[0] == 3:
            ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)
        else:  # in python2.x
            ctypes.windll.shell32.ShellExecuteW(None, u"runas", unicode(sys.executable), unicode(__file__), None, 1)

        things_in_folder = os.listdir(path)
        for thing in things_in_folder:
            if os.path.isdir(thing):
                command = 'rd /s/q "' + path + '/' + thing + '"'
                try:
                    os.system(command)
                except EnvironmentError:
                    print('\n' + thing + ' 文件夹删除失败')

        print('\n' + '当前目录下所有文件夹删除成功')
    files_filter(model=input("请输入文件批处理类型:"))


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
    elif model == '4':
        delete_all_empty_folder(path)
    elif model == '5':
        file_delete(all_files, path)
    elif model == '6':
        file_extractor(all_files, path)
    elif model == '7':
        delete_selected_folder(path)
    elif model == '8':
        delete_all_folder(path)
    else:
        os.system("pause")


if __name__ == '__main__':
    print('输入: \n')
    print(' 1 为音频筛选;\n')
    print(' 2 为视频筛选;\n')
    print(' 3 为文件全提取(除之前的视频与音频外);\n')
    print(' 4 为删除全部空白文件夹及文件;\n')
    print(' 5 为删除指定格式的文件;\n')
    print(' 6 为筛选指定格式的文件;\n')
    print(' 7 为删除当前目录的指定文件夹;\n')
    print(' 8 为删除当前目录的所有文件夹;\n')
    print('输入其他为退出\n')
    files_filter(model=input("请输入文件批处理类型:"))
