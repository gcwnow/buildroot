#!/bin/sh

TARGET_DIR=$1

for i in ar as ld ld.bfd nm objcopy ranlib strip ; do
	rm -f ${TARGET_DIR}/usr/mipsel-gcw0-linux-uclibc/bin/$i
done
