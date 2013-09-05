#!/bin/sh

if [ -z "$1" ] || [ "x$1" = "xstart" ]; then

    mkdir -p /usr/local
    for i in bin etc home lib sbin share; do
        mkdir -p /usr/local/$i
    done

	# Symlink ~/.local to /usr/local
	if [ ! -L /usr/local/home/.local ] ; then
		ln -s /usr/local /usr/local/home/.local
	fi

	# Symlink ~/.config to /usr/local/etc
	if [ ! -L /usr/local/home/.config ] ; then
		ln -s /usr/local/etc /usr/local/home/.config
	fi

    if [ ! -f /etc/local/timezone ]; then
        echo 'CET-1CEST,M3.5.0,M10.5.0' > /etc/local/timezone
    fi

fi

