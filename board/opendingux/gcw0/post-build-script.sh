#!/bin/sh

TARGET_DIR=$1

# Remove binutils executables we don't use
for i in ar as ld ld.bfd nm objcopy ranlib strip ; do
	rm -f ${TARGET_DIR}/usr/mipsel-gcw0-linux-uclibc/bin/$i
done

# We use xinetd, so no need for a startup script for the SSH daemons
# and the FTP server.
rm -f ${TARGET_DIR}/etc/init.d/S50sshd
rm -f ${TARGET_DIR}/etc/init.d/S50dropbear
rm -f ${TARGET_DIR}/etc/init.d/S70vsftpd
