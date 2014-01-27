#!/bin/sh

DIR=`dirname "$0"`
TARGET_DIR=$1

if [ ! -f "${TARGET_DIR}/usr/share/od-rescue-cd/images/data.bin" \
	-o ! -f "${TARGET_DIR}/usr/share/od-rescue-cd/images/system.bin" \
	-o ! -f "${TARGET_DIR}/usr/share/od-rescue-cd/images/mbr.bin" \
	-o ! -f "${TARGET_DIR}/usr/share/od-rescue-cd/images/ubiboot-v11_ddr2_256mb.bin" \
	-o ! -f "${TARGET_DIR}/usr/share/od-rescue-cd/images/ubiboot-v20_mddr_512mb.bin" ] ; then
	echo "Flash images not found! Please install them in ${TARGET_DIR}/usr/share/od-rescue-cd/images"
	echo "The following files are required: data.bin system.bin mbr.bin ubiboot-v11_ddr2_256mb.bin ubiboot-v20_mddr_512mb.bin"
	exit 1
fi

exit 0
