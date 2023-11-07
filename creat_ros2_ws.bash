#!/bin/bash
# 注意!!!!!!! 路经中不要有中文(桌面文件夹为中文),不然colcon 编译报错
mkdir -pv ./dev_ws/src
cd ./dev_ws/src || exit  # z注意是在大工作空间下建立src再使用pkg创建包,最后在包之中的src文件夹编辑代码
ros2 pkg create sub_project_name --node-name NODE_NAME --build-type ament_cmake --dependencies rclcpp --package-format 3
# 使用包工具创建一个标准的包模板,自动配置其编译器等
# git clone https://github.com/ros/ros_tutorials.git -b humble-devel
# 初始化包安装器
# echo 'king5490' | sudo -S rosdep init & rosdep update
# 自动安装依赖
# rosdep install -i --from-path src --rosdistro humble -y
# 当上述l两个的官方命令不好使时，使用如下国内镜像代理的命令
# sudo rosdepc init & rosdepc update
# rosdepc install -i --from-path src --rosdistro 你的ros版本代号 -y
cd .. || exit
bash source /opt/ros/humble/setup.bash
# 编译之前必须再加载一次ros
colcon build --symlink-install --packages-select sub_project_name
bash source /opt/ros/humble/setup.bash 
# 初始化ros,测试工作环境是否配置成功
# sudo bash . install/local_setup.bash
# 加载当前工作空间，当前工作空间内的相关包会覆盖ros2底层的相关包
code ./
# 打开VScode,使用catkin来配置当前工作空间的vscode配置

# 当一个terminal source 过当前的包setup脚本后,包的重新编译后此terminal不需要再一次source

