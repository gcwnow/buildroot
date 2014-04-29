#!/bin/sh

VERSION=0.2

DIR=`dirname "$0"`
IMAGES_DIR=$1
TARGET=${IMAGES_DIR}/opendingux-rescue-cd-v${VERSION}.iso
SYSLINUX_DIR=${IMAGES_DIR}/../build/syslinux-4.07/

set -e
set -v

genisoimage -o ${TARGET} -b isolinux.bin -c boot.cat -no-emul-boot \
	-boot-load-size 4 -boot-info-table -V OD_RESCUE_CD_V${VERSION} \
	-graft-points ${IMAGES_DIR}/isolinux.bin ${IMAGES_DIR}/bzImage \
	${DIR}/isolinux.cfg ldlinux.c32=${SYSLINUX_DIR}/core/ldlinux.elf \
	rootfs.xz=${IMAGES_DIR}/rootfs.cpio.xz

${SYSLINUX_DIR}/utils/isohybrid ${TARGET}
