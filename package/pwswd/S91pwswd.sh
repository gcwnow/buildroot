#!/bin/sh

HOME=`cat /etc/passwd |head -1 |cut -d':' -f 6` /usr/sbin/pwswd &
