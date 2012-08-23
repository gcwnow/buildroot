#!/bin/sh
#
# Simple script to load/store ALSA parameters (volume...)
#

ASOUND_STATEFILE=/etc/asound.state
VOLUME_STATEFILE=/etc/local/volume.state
CONTROL=SoftMaster

case "$1" in
	start)
		echo "Creating $CONTROL control..."
		/usr/sbin/alsactl -f $ASOUND_STATEFILE restore

		echo "Loading sound volume..."
		if [ -f $VOLUME_STATEFILE ]; then
			/usr/bin/amixer set $CONTROL `cat $VOLUME_STATEFILE`
		fi
		;;
	stop)
		echo "Storing sound volume..."
		echo `/usr/bin/alsa-getvolume default $CONTROL` > $VOLUME_STATEFILE
		;;
	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

exit $?

