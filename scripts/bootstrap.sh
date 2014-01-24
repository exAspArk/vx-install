#!/bin/bash

set -e

DIST=${DIST:-precise}
IMAGE=/tmp/$DIST-chroot
LOG=/tmp/bootstrap.log

notice () {
  echo " --> $1"
}

mount_all () {
  notice "mount filesystems"
  sudo mount -t proc proc $1/proc/
  sudo mount -t sysfs sys $1/sys/
  sudo mount -o bind /dev $1/dev/
}

copy_image () {
  notice "build image $1"
  sudo cp -r $IMAGE $1
}

echo > $LOG

notice "add ansible ppa"
echo "yes" | sudo add-apt-repository ppa:rquillo/ansible >> $LOG

notice "apt-get update"
sudo apt-get -qqy update >> $LOG

notice "install packages"
sudo apt-get -qqy install ansible debootstrap >> $LOG

notice "run debootstrap in $IMAGE"
sudo debootstrap $DIST $IMAGE >> $LOG

notice "apt-get update in chroot"
sudo chroot $IMAGE apt-get -qqy update >> $LOG

notice "install packages in chroot"
sudo chroot $IMAGE apt-get -qqy install python python-apt python-pycurl >> $LOG

copy_image $IMAGE-mq
mount_all $IMAGE-mq

copy_image $IMAGE-web
mount_all $IMAGE-web

copy_image $IMAGE-worker
mount_all $IMAGE-worker

notice "run ansible setup"
( cd ./ansible && sudo -E ansible -v -c chroot -i testing all -m setup >> $LOG )
