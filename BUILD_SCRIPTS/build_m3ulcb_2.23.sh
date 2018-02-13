#!/bin/bash

WORK=`pwd`
echo $WORK

git clone git://git.yoctoproject.org/poky
git clone git://git.linaro.org/openembedded/meta-linaro.git
git clone git://git.openembedded.org/meta-openembedded
git clone git://github.com/renesas-rcar/meta-renesas

cd $WORK/poky
git checkout -b tmp yocto-2.1.3
cd $WORK/meta-linaro
git checkout -b tmp 2f51d38048599d9878f149d6d15539fb97603f8f
cd $WORK/meta-openembedded
git checkout -b tmp 55c8a76da5dc099a7bc3838495c672140cedb78e
cd $WORK/meta-renesas
git checkout -b tmp 7acbf5e2f99c59478adbc73c6a40d314589a3009

cd $WORK/meta-renesas
export PATCH_DIR=meta-rcar-gen3/docs/sample/patch/patch-for-linaro-gcc
patch -p1 < ${PATCH_DIR}/0001-rcar-gen3-add-readme-for-building-with-Linaro-Gcc.patch
unset PATCH_DIR



cd $WORK/
PKGS_DIR=/home/YOCTO/pkg/renesas/v2.23.0
cd $WORK/meta-renesas
#sh meta-rcar-gen3/docs/sample/copyscript/copy_proprietary_softwares.sh -f $PKGS_DIR
sh meta-rcar-gen3/docs/sample/copyscript/copy_evaproprietary_softwares.sh -f $PKGS_DIR

cd $WORK
source poky/oe-init-build-env

#cp $WORK/meta-renesas/meta-rcar-gen3/docs/sample/conf/m3ulcb/linaro-gcc/bsp/*.conf ./conf/.
#cp $WORK/meta-renesas/meta-rcar-gen3/docs/sample/conf/m3ulcb/linaro-gcc/gfx-only/*.conf ./conf/.
cp $WORK/meta-renesas/meta-rcar-gen3/docs/sample/conf/m3ulcb/linaro-gcc/mmp/*.conf ./conf/.

cd $WORK/build
cp conf/local-wayland.conf conf/local.conf
echo "DISTRO_FEATURES_append = \" use_eva_pkg\"" >> conf/local.conf
echo "DL_DIR=\"/home/YOCTO/downloads\"" >> conf/local.conf

#for adding mkfs.ext4.
echo "IMAGE_INSTALL_append = \" e2fsprogs\"" >> conf/local.conf

bitbake core-image-weston
