FROM tiger0421/ros-gpu-gazebo:1.0-glvnd-runtime-ubuntu18.04

WORKDIR /root
RUN apt update && \
	apt upgrade -y && \
	apt install -y \
		ninja-build \
	&& \
	mkdir -p /cartographer_ws/src/ && \
	cd /cartographer_ws/ && \
	wstool init src && \
	wstool merge -t src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall && \
	wstool update -t src && \
	sh src/cartographer/scripts/install_proto3.sh && \
	bash -c ' \
		. /opt/ros/melodic/setup.bash; \
		rosdep init; \
		rosdep update; \
		rosdep install --from-paths src --ignore-src --rosdistro=melodic -y; \
		catkin_make_isolated --install --use-ninja; \
	' && \
	apt autoremove -y && \
	apt clean && \
	rm -rf /var/lib/apt/lists/* && \
	echo "source /cartographer_ws/devel_isolated/setup.bash" >> ~/.bashrc
