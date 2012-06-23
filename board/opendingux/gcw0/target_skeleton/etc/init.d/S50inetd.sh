#!/bin/sh

case "$1" in

	start)
		echo "Starting inetd..."
		/usr/sbin/inetd
		;;

	stop)
		echo "Stopping inetd..."

		if ! killall inetd 2> /dev/null ; then
			echo "Inetd was not running."
		else

			# stop any running telnet session
			if pidof telnetd > /dev/null ; then
				echo "Closing telnet sessions..."
				killall -15 telnetd
			fi
		fi
		;;

	restart)
		$0 stop
		$0 start
		;;

	status)
		if pidof inetd -o $$ > /dev/null ; then
			echo "running"
		else
			echo "stopped"
		fi
		;;

	*)
		echo "Usage: $0 {start|stop|status}"
		exit 1
esac

