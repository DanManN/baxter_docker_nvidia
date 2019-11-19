xhost +local:root
docker run -it \
	--rm \
	--privileged \
	--env="DISPLAY=unix:0.0" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--mount type=bind,source="$(pwd)"/mnt_me,target=/root/ws_host \
	baxter_nvidia
xhost -local:root
