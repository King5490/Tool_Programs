import os
import time
import re

def merge_ris_files():
    # 获取当前文件夹路径
    current_dir = os.getcwd()

    # 指定输出文件路径及文件名
    output_file = os.path.join(current_dir, "all_in_one.ris")

    # 获取当前文件夹中的所有 .ris 文件列表
    ris_files = [file for file in os.listdir(current_dir) if file.endswith(".ris") and not re.search('all_in_one', file)]

    # 遍历所有 .ris 文件并将内容合并到输出文件中
    with open(output_file, "w", encoding="utf-8") as output:
        for idx, ris_file in enumerate(ris_files):
            print(f"Processing file: {ris_file} ({idx + 1}/{len(ris_files)})")
            ris_file_path = os.path.join(current_dir, ris_file)
            try:
                with open(ris_file_path, "r", encoding="utf-8") as file:
                    output.write(file.read())
            except EnvironmentError:
                    print('\n' + ris_file + ' 该文件内可能存在乱码，或者文件编码问题')

            output.write("\n")  # 在每个文件内容之间插入一个空行
            
    # 显示合并完成的消息
    print("All files have been merged.")

    os.system("pause")
if __name__ == '__main__':
	# 调用函数
	merge_ris_files()
	