#!/bin/bash
sudo docker build ./ping-ros-cpp -t ping_ros_cpp

if [ $? -ne 0 ]; then
    exit
fi

# Home Networking settings
ROS_MASTER_URI="http://192.168.0.161:11311"
ROS_IP="192.168.0.161"
sudo docker run \
	--hostname ping \
	-it \
	--rm \
	--net=host \
	-e ROS_MASTER_URI=$ROS_MASTER_URI \
    	-e ROS_IP=$ROS_IP \
	--add-host controller:127.0.0.1 \
	--add-host coppeliaSim:192.168.0.161 \
	ping_ros_cpp:latest \

#  	bash
#	--user root \

# Lab Networking settings
#ROS_MASTER_URI="http://10.10.10.10:11311"
#ROS_IP="10.10.10.101"
#sudo docker run \
#	--hostname controller \
#	-it \
#	--rm \
#	--net=host \
#	-e ROS_MASTER_URI=$ROS_MASTER_URI \
#    	-e ROS_IP=$ROS_IP \
#	--add-host controller:127.0.0.1 \
#	--add-host coppeliaSim:10.10.10.101 \
#	--add-host niryo-desktop:10.10.10.10 \
#	ros_controller:latest \
##  	bash
##	--user root \
