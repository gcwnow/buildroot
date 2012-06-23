#!/bin/sh

if [ -z "$1" ] || [ "x$1" = "xstart" ]; then

    if [ ! -c /dev/input/mice ]
    then
        mkdir -p /dev/input
        ln -sf /dev/mice /dev/input/mice
    fi

fi

