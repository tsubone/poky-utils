#!/bin/bash

echo "$PWD"
topdir="$PWD"
echo "$topdir"

YOCTO_DIR=/home/YOCTO

git clone git://git.yoctoproject.org/poky.git
cd poky
git checkout -b morty origin/morty
cd ..

git clone git://git.openembedded.org/meta-openembedded
cd meta-openembedded
git checkout -b morty origin/morty
cd ..

git clone git://git.yoctoproject.org/meta-virtualization
cd meta-virtualization
git checkout -b morty origin/morty
cd ..

git clone git://git.yoctoproject.org/meta-cloud-services
cd meta-cloud-services
git checkout -b morty origin/morty
cd ..

git clone git://github.com/tsubone/meta-spice-native.git
cd meta-spice-native
git config user.name "Takashi Tsubone"
git config user.email "takashi.tsubone@gmail.com"
#git checkout -b morty origin/morty
cd ..

cd poky
source oe-init-build-env

echo "BBLAYERS =+ \" $topdir/meta-openembedded/meta-oe \""  >> conf/bblayers.conf
echo "BBLAYERS =+ \" $topdir/meta-openembedded/meta-python \""  >> conf/bblayers.conf
echo "BBLAYERS =+ \" $topdir/meta-openembedded/meta-networking \""  >> conf/bblayers.conf
echo "BBLAYERS =+ \" $topdir/meta-virtualization \""  >> conf/bblayers.conf
echo "BBLAYERS =+ \" $topdir/meta-cloud-services \""  >> conf/bblayers.conf
echo "BBLAYERS =+ \" $topdir/meta-spice-native \""  >> conf/bblayers.conf

echo "MACHINE = \"qemux86-64\"" >> conf/local.conf

# use download cache directory
echo "DL_DIR = \"${YOCTO_DIR}/downloads\"" >> conf/local.conf

#echo "EXTRA_IMAGE_FEATURES = \"dbg-pkgs\""  >> conf/local.conf

#echo "PACKAGE_DEBUG_SPLIT_STYLE = 'debug-file-directory'" >> conf/local.conf

# install psmisc (pstree..) to image file
#echo "IMAGE_INSTALL_append = \" psmisc\"" >> conf/local.conf
#echo "IMAGE_INSTALL_append = \" pciutils\"" >> conf/local.conf

# install psmisc (pstree..) to image file
# echo "IMAGE_INSTALL_append = \" psmisc\"" >> conf/local.conf

bitbake core-image-sato
