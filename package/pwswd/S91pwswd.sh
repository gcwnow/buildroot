#!/bin/sh

case "$1" in
start)
	echo "Starting power slider daemon..."
	export HOME=`cat /etc/passwd |head -1 |cut -d':' -f 6`
	start-stop-daemon -S -b -x /usr/sbin/pwswd
	unset HOME
	;;
stop)
	echo "Stopping power slider daemon..."
	start-stop-daemon -K -x /usr/sbin/pwswd
	;;
*)
	echo "Usage: $0 {start|stop}"
	exit 1
esac

exit $?
