xhost +local:root
docker run -it \
	--rm \
	--privileged \
	--env="DISPLAY=unix:0.0" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	baxter_sim
xhost -local:root
