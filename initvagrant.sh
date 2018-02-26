#!/bin/bash

# this script is run by the root user in the virtual machine

set -e
set -x

echo "Initial setup of ros-vagrant instance."
echo "Setting new Vagrant user."
VAGRANT_USER=ubuntu
if [ -e /home/vagrant ]; then
    # prefer vagrant user
    VAGRANT_USER=vagrant
fi

echo "Try to resize partition."
# artful rootfs is 2GB without resize:
sudo resize2fs /dev/sda1

usermod -a -G dialout $VAGRANT_USER

/vagrant/install-prereqs-ros.sh -y

# run-in-terminal-window uses xterm:
apt-get install -y xterm

sudo -u $VAGRANT_USER ln -fs /vagrant/screenrc /home/$VAGRANT_USER/.screenrc

# adjust environment for every login shell:
DOT_PROFILE=/home/$VAGRANT_USER/.profile
echo "source /vagrant/shellinit.sh" |
    sudo -u $VAGRANT_USER dd conv=notrunc oflag=append of=$DOT_PROFILE

#Plant a marker for sim_vehicle that we're inside a vagrant box
touch /ardupilot.vagrant

# Now you can run
# vagrant ssh -c "screen -d -R"
