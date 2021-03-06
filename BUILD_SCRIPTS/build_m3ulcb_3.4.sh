#!/bin/bash

WORK=`pwd`
echo $WORK

git clone git://git.yoctoproject.org/poky
git clone git://git.linaro.org/openembedded/meta-linaro.git
git clone git://git.openembedded.org/meta-openembedded
git clone git://github.com/renesas-rcar/meta-renesas

cd $WORK/poky
git checkout -b tmp 16e22f3e37788afb83044f5089d24187d70094bd
cd $WORK/meta-linaro
git checkout -b tmp 30f0f5e158ba29c4b1ccfdd66f0368726e4179e0
cd $WORK/meta-openembedded
git checkout -b tmp 6e3fc5b8d904d06e3aa77e9ec9968ab37a798188
cd $WORK/meta-renesas
git checkout -b tmp 0f4c656f1e8304ce13f43b07907fac5d9b281e4f

cd $WORK/meta-renesas
export PATCH_DIR=meta-rcar-gen3/docs/sample/patch/patch-for-linaro-gcc
patch -p1 < ${PATCH_DIR}/0001-rcar-gen3-add-readme-for-building-with-Linaro-Gcc.patch
unset PATCH_DIR

cd $WORK/
PKGS_DIR=/home/YOCTO/pkg/renesas/v3.4.0
cd $WORK/meta-renesas
#sh meta-rcar-gen3/docs/sample/copyscript/copy_proprietary_softwares.sh -f $PKGS_DIR
sh meta-rcar-gen3/docs/sample/copyscript/copy_evaproprietary_softwares.sh -f $PKGS_DIR

cd $WORK
source poky/oe-init-build-env

#cp $WORK/meta-renesas/meta-rcar-gen3/docs/sample/conf/m3ulcb/poky-gcc/bsp/*.conf ./conf/.
#cp $WORK/meta-renesas/meta-rcar-gen3/docs/sample/conf/m3ulcb/poky-gcc/gfx-only/*.conf ./conf/.
cp $WORK/meta-renesas/meta-rcar-gen3/docs/sample/conf/m3ulcb/poky-gcc/mmp/*.conf ./conf/.


cd $WORK/build
cp conf/local-wayland.conf conf/local.conf
echo "DISTRO_FEATURES_append = \" use_eva_pkg\"" >> conf/local.conf
echo "DL_DIR=\"/home/YOCTO/downloads\"" >> conf/local.conf

#for adding mkfs.ext4.
echo "IMAGE_INSTALL_append = \" e2fsprogs\"" >> conf/local.conf

bitbake core-image-weston
