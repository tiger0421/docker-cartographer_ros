#!/bin/bash
xhost +local:root

docker run -it --rm --name cartographer \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    --gpus all \
    -w /root/ \
    tiger0421/cartographer_ros:latest
    /bin/bash

xhost -local:root
