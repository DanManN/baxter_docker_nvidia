FROM baxter_simulator

RUN apt-get update
RUN apt-get install -y mesa-utils kmod binutils

# install nvidia driver
ADD NVIDIA-DRIVER.run /tmp/NVIDIA-DRIVER.run
RUN sh /tmp/NVIDIA-DRIVER.run --ui=none --no-kernel-module --install-libglvnd
RUN rm /tmp/NVIDIA-DRIVER.run

ADD baxter.sh /root/ws_baxter/baxter.sh
