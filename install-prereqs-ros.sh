#!/bin/bash

# this script is run by the root user in the virtual machine

set -e
set -x

echo "Setting up repo for ROS."

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

### Install ROS : taken from http://wiki.ros.org/kinetic/Installation/Ubuntu
# Configure your Ubuntu repositories
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# Configure Gazebo OSRF repositories
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get update

# Installation
echo "Installing ROS."
sudo apt-get -y install ros-kinetic-ros-base
sudo apt-get -y install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools
echo "Installing Gazebo8 with ROS binding."
sudo apt-get -y install gazebo8 ros-kinetic-gazebo8-ros

# Initialize rosdep
sudo rosdep init
su - vagrant -c 'rosdep update'

# Environment setup
echo "source /opt/ros/kinetic/setup.bash" >> /home/vagrant/.bashrc

# Installing mavros
echo "Installing Mavros."
sudo apt-get -y install ros-kinetic-mavros
