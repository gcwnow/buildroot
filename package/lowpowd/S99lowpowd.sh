#!/bin/sh

case "$1" in
start)
	echo "Starting low power warning daemon..."
	start-stop-daemon -S -b -x /usr/sbin/lowpowd
	;;
stop)
	echo "Stopping low power warning daemon..."
	start-stop-daemon -K -x /usr/sbin/lowpowd
	;;
*)
	echo "Usage: $0 {start|stop}"
	exit 1
esac

exit $?
