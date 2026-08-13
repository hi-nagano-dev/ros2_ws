FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    git \
    vim \
    wget \
    curl \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ros2_ws

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc \
 && echo "[ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash" >> ~/.bashrc

CMD ["/bin/bash"]
