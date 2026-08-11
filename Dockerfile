FROM osrf/ros:humble-desktop

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-colcon-common-extensions \
    python3-rosdep \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /ros2_ws

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc \
 && echo "source /ros2_ws/install/setup.bash 2>/dev/null || true" >> ~/.bashrc

CMD ["/bin/bash"]
