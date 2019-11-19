#!/usr/bin/env bash

docker build -t baxter_simulator ./baxter_simulator
if [[ ! -f NVIDIA-DRIVER.run ]]; then
	version="$(glxinfo | grep "OpenGL version string" | rev | cut -d" " -f1 | rev)"
	wget http://us.download.nvidia.com/XFree86/Linux-x86_64/"$version"/NVIDIA-Linux-x86_64-"$version".run
	mv NVIDIA-Linux-x86_64-"$version".run NVIDIA-DRIVER.run
fi
docker build -t baxter_nvidia .
