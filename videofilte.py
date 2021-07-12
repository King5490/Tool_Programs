#!/usr/bin/env python3
# -*-coding:utf-8-*-
# Author: King
# Date: 2021/6/30
# Last Modified by: 24677
# Last Modified time: 星期三 19:51
# 本脚本用于筛选出相同编码和分辨率的视频，为了方便使用视频合成软件进行无重新编码合成
# Tips:涉及到读取文件对的操作，一定要记得关闭文件
# 筛选类似视频，删除小视频，小图片
import cv2
import win32api
import pathlib
from os import system


class video_type:
    def __init__(self, path, resolution, codec, type_cont):
        self.path = path
        self.resolution = resolution
        self.codec = codec
        self.type_cont = type_cont


if __name__ == '__main__':

    cwd = pathlib.Path.cwd()

    all_files = [path for path in cwd.iterdir() if path.is_file()]
    all_types = [video_type(cwd, '分辨率', '编码格式', '同类型文件的数量')]

    print('视频分类开始')

    for file in all_files:
        if not file.name[len(file.name) - 2:len(file.name)] == 'py':
            file_cap = cv2.VideoCapture(file.name)
            resolution = str(int(file_cap.get(cv2.CAP_PROP_FRAME_WIDTH))) + 'x' + str(int(
                file_cap.get(cv2.CAP_PROP_FRAME_HEIGHT)))
            codec = int(file_cap.get(cv2.CAP_PROP_FOURCC))
            codec = chr(codec & 0xFF) + chr((codec >> 8) & 0xFF) + \
                chr((codec >> 16) & 0xFF) + chr((codec >> 24) & 0xFF)
            file_cap.release()

            type_is_exist = False
            for type in all_types:
                if type.resolution == resolution and type.codec == codec:
                    type.type_cont += 1
                    type_is_exist = True
                    file_folder = cwd.joinpath(resolution + '_' + codec)

                    if type.type_cont == 2:
                        # 当找到两个及两个以上的同类型的文件时检测并创建该类型文件夹，并将第一个这样的文件移入
                        pathlib.Path.mkdir(file_folder)
                        win32api.MoveFile(str(type.path), str(
                            file_folder.joinpath(type.path.name)))
                    if type.type_cont >= 2:
                        # 移入后续的同类型文件
                        win32api.MoveFile(str(file), str(
                            file_folder.joinpath(file.name)))

            if not type_is_exist:
                all_types.append(video_type(file, resolution, codec, 1))

    for type in all_types:
        print(type.resolution, type.codec, type.type_cont)
    print('视频分类完成')
    # system("pause")
