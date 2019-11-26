FROM baxter_simulator

RUN apt-get update
RUN apt-get install -y mesa-utils kmod binutils

# install nvidia driver
ADD NVIDIA-DRIVER.run /tmp/NVIDIA-DRIVER.run
RUN sh /tmp/NVIDIA-DRIVER.run --ui=none --no-kernel-module --install-libglvnd
RUN rm /tmp/NVIDIA-DRIVER.run

# install moveit
RUN apt-get -qq update && \
    # apt-get -qq upgrade && \
    apt-get -qq install -y ros-kinetic-moveit && \
    # Clear apt-cache to reduce image size
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ros-planning/moveit_robots.git src/moveit_robots && \
    catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    # Status rate is limited so that just enough info is shown to keep Docker from timing out, but not too much
    # such that the Docker log gets too long (another form of timeout)
    catkin build --jobs 1 --limit-status-rate 0.001 --no-notify


ADD baxter.sh /root/ws_baxter/baxter.sh
ENTRYPOINT ["/root/ws_baxter/baxter.sh"]
