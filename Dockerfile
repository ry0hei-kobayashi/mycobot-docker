FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

#↓nvidiaがない場合
#FROM ubuntu:22.04

#-----------------------------
# Environment Variables
#-----------------------------
ENV LC_ALL=C.UTF-8
ENV export LANG=C.UTF-8
# no need input key
ENV DEBIAN_FRONTEND noninteractive


SHELL ["/bin/bash", "-c"]

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

#-----------------------------
# Install common pkg
#-----------------------------
RUN apt-get -y update
RUN apt-get -y install git ssh python3-pip wget net-tools vim curl make build-essential lsb-release libgl1-mesa-dev python3-wheel python3-pip python-is-python3

#-----------------------------
# Install humble pkg
#-----------------------------
ENV UBUNTU_CODENAME=focal
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list
RUN apt-get update
RUN apt-get install -y ros-humble-desktop-full \
    ros-humble-moveit \
    ros-humble-controller-manager \
    ros-humble-gazebo-ros \
    ros-humble-moveit-visual-tools \
    ros-humble-gazebo-ros2-control \
    ros-humble-gripper-controllers \
    ros-humble-ros-gz \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-joint-state-publisher-gui \
    python3-rosdep \
    python3-colcon-common-extensions \ 
    ros-humble-gazebo-ros-pkgs 

RUN pip install pymycobot

#-----------------------------
# Build Workspace
#-----------------------------
RUN mkdir -p /colcon_ws/src
WORKDIR /colcon_ws/src
#RUN git clone -b humble https://github.com/elephantrobotics/mycobot_ros2.git 
RUN git clone --depth 1 https://github.com/elephantrobotics/mycobot_ros2.git
#↑本家
#RUN https://github.com/Tiryoh/mycobot_ros.git
#↑ros1のgazebo付き

# moveitを含んだやつ 動作未確認
#RUN git clone https://github.com/automaticaddison/mycobot_ros2.git
#RUN git clone --recurse-submodules -b humble https://github.com/moveit/moveit_task_constructor.git 

#RUN git clone -b ros2 https://github.com/moveit/py_binding_tools.git

# moveitを含んだやつ 動作未確認
#COPY ./moveit_task_constructor /colcon_ws/src/
#COPY ./mycobot_ros2 /colcon_ws/src/

RUN rosdep init && rosdep update && cd /colcon_ws && rosdep install --from-paths src --ignore-src -r -y

RUN cd .. && . /opt/ros/humble/setup.bash && colcon build && . install/setup.bash

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash]


