#!/bin/sh

if [ -z "$1" ] || [ "x$1" = "xstart" ]; then
    /usr/sbin/udhcpd /etc/udhcpd.conf
fi
