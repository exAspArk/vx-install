#!/bin/bash

set -e

DIST=${DIST:-precise}
IMAGE=/tmp/$DIST-chroot
ROLES=(mq worker web)

echo "yes" | sudo  add-apt-repository ppa:rquillo/ansible
sudo apt-get -qy update
sudo apt-get -qy install ansible debootstrap

sudo debootstrap $DIST $IMAGE
sudo chroot $IMAGE apt-get update
sudo chroot $IMAGE apt-get -qy install python python-apt python-pycurl

for role in $ROLES ; do
  sudo cp -r $IMAGE $IMAGE-$role

  pushd $IMAGE-$role
    sudo mount -t proc proc proc/
    sudo mount -t sysfs sys sys/
    sudo mount -o bind /dev dev/
  popd

  pushd ./ansible
    sudo -E ansible -v -c chroot -i testing all -m setup > /dev/null
  popd
done
