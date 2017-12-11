![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

Contents:

- Bash scripts for deploying NVidia-Docker on new 14.04/16.04/17.04 hosts
- Dockerfile to create X-accelerated containers with novnc frontend, image hosted on Dockerhub

Start X CUDA session

docker run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES='0,1' --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker sh /root/run-nv

Initial vnc password is 00000000
noVNC website is avaliable at port 6080

- Initial v0.1 pre-release
- Wine v0.2 addon pre-release
- Nvidia-Docker 2.0 integration release

Because of dockerd integration with nvidia-docker2, Rancher now also plays nice with NV GPU container instances
