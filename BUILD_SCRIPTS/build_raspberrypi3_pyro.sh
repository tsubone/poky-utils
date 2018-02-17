#!/bin/bash

WORK=`pwd`
echo $WORK

git clone -b pyro git://git.yoctoproject.org/poky
git clone -b pyro git://git.openembedded.org/meta-openembedded
git clone -b pyro git://git.yoctoproject.org/meta-raspberrypi

cd $WORK
source poky/oe-init-build-env

cd $WORK/build

echo "MACHINE = \"raspberrypi3\"" >> conf/local.conf
echo "DL_DIR=\"/home/YOCTO/downloads\"" >> conf/local.conf

#for adding mkfs.ext4.
echo "IMAGE_INSTALL_append = \" e2fsprogs\"" >> conf/local.conf

echo "BBLAYERS =+ \" $WORK/meta-openembedded/meta-oe\""         >> conf/bblayers.conf
echo "BBLAYERS =+ \" $WORK/meta-openembedded/meta-multimedia\"" >> conf/bblayers.conf
echo "BBLAYERS =+ \" $WORK/meta-openembedded/meta-networking\"" >> conf/bblayers.conf
echo "BBLAYERS =+ \" $WORK/meta-openembedded/meta-python\""     >> conf/bblayers.conf
echo "BBLAYERS =+ \" $WORK/meta-raspberrypi\""                  >> conf/bblayers.conf

bitbake core-image-weston
