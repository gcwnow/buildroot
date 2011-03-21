#!/bin/sh

for event in `ls -d /sys/class/input/event*` ; do
	NAME=`basename "$event"`
	KEY=`cat "$event/device/capabilities/key"`
	if [ "$KEY" != "0" ] ; then
		EVENT="$NAME"
		break
	fi
done


case "$1" in
start)
	echo "Starting power slider daemon..."
	export HOME=`cat /etc/passwd |head -1 |cut -d':' -f 6`
	start-stop-daemon -S -b -x /usr/sbin/pwswd -- -e /dev/$EVENT
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
