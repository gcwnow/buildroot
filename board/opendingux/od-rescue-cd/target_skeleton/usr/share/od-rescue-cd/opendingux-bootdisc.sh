#!/bin/sh

# Version of this script
VERSION=0.1

IMAGES_DIR="/usr/share/od-rescue-cd/images"

export TERM="linux"
export DIALOGOPTS="--colors --backtitle \"OpenDingux Rescue Disc v${VERSION}\""
echo "screen_color = (RED,RED,ON)" > /tmp/dialog_err.rc

CONFIG=""
FLASH=""

step_one() {
	RETAIL=""
	PROTO=""
	[ "$CONFIG" = "Retail unit" ] && RETAIL=on
	[ "$CONFIG" = "Prototype" ] && PROTO=on
	[ -z "$RETAIL" -a -z "$PROTO" ] && RETAIL=on

	CONFIG=$( \
		exec 3>&1 ; \
		/usr/bin/dialog --output-fd 3 --cancel-label "Power off" --radiolist \
		"Please select the configuration corresponding to the GCW-Zero unit:" 0 0 0 \
		"Retail unit" "SE, KickStarter or regular edition" "$RETAIL" \
		"Prototype" "First-gen 256MiB RAM prototype" "$PROTO" \
		3>&1 >&2 ; 3>&- )

	[ -z "$CONFIG" ] && return 1
	return 0
}

step_two() {
	FLASH=$( \
		exec 3>&1 ; \
		/usr/bin/dialog --output-fd 3 --cancel-label "Back" --radiolist \
		"Select what you want to flash." 0 0 0 \
		"System" "Restore the system partition" "on" \
		"All" "\Zb\Z1Flash the MBR, bootloader, system & data partitions /!\\\Zn" "" \
		3>&1 >&2 ; 3>&- )
	[ -z "$FLASH" ] && return 1

	PARAMS=''
	if [ "$FLASH" = "All" ] ; then
		/usr/bin/dialog --defaultno --yesno \
			"\Zb\Z1WARNING: Reflashing the data partition will irremediably wipe all your data.\nDo you want to continue?\Zn" 0 0
		[ $? -ne 0 ] && return 2
	fi
	return 0
}


step_three() {
	if [ "$FLASH" = "All" ] ; then
		FLASH_ALL="\Zb\Z1Yes\Zn"
	else
		FLASH_ALL="No"
	fi
	/usr/bin/dialog --defaultno --yes-label "Flash!" --no-label "Back" \
		--yesno "This is the configuration you selected:\n
*   GCW-Zero model:         \Zb\Z1$CONFIG\Zn\n
*   Flash MBR:              $FLASH_ALL\n
*   Flash Bootloader:       $FLASH_ALL\n
*   Flash System partition: \Zb\Z1Yes\Zn\n
*   Flash Data partition:   $FLASH_ALL\n\n
Do you want to flash now?" 0 0
	[ $? -ne 0 ] && return 1

	CONFIG2=""
	if [ "$CONFIG" = "Retail unit" ] ; then
		CONFIG2="v20_mddr_512mb"
	elif [ "$CONFIG" = "256MiB Prototype" ] ; then
		CONFIG2="v11_ddr2_256mb"
	fi

	COMMAND="ingenic-boot --config=gcw0_${CONFIG2} --system=${IMAGES_DIR}/system.bin"
	[ $FLASH_ALL != "No" ] && COMMAND="$COMMAND --mbr=${IMAGES_DIR}/mbr.bin --boot=${IMAGES_DIR}/ubiboot-${CONFIG2}.bin --data=${IMAGES_DIR}/data.bin"

	clear
	$COMMAND

	if [ $? -ne 0 ] ; then
		DIALOGRC="/tmp/dialog_err.rc" \
			/usr/bin/dialog --msgbox "ERROR!\n\nFlashing failed!" 0 0
		return 2
	fi

	/usr/bin/dialog --yesno "Flashing suceeded! Good job!\n\nDo you have another unit to flash?" 0 0
	[ $? -eq 0 ] && return 2
	return 0
}


/usr/bin/dialog --msgbox "Welcome to the OpenDingux Rescue Disc.\n
This disc can be used to reflash a GCW-Zero." 0 0

GCW_ZERO_PRESENT=no
while /bin/true ; do
	/usr/bin/dialog --infobox "Detecting the GCW-Zero..." 0 0

	ingenic-boot --probe >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
		GCW_ZERO_PRESENT=Yes
		break
	fi

	# Wait at least 1 second between attemps, so that
	# the message is readable...
	sleep 1

	DIALOGRC="/tmp/dialog_err.rc" \
		/usr/bin/dialog --yes-label "Retry" --no-label "Power off" \
		--yesno "The GCW-Zero was not detected.\n\n
Make sure it is plugged to a USB port of your PC, and verify that it is
in 'BOOT' mode. To switch the GCW-Zero to 'BOOT' mode, press SELECT while
you boot the device, or while you hit the reset button. The screen will stay
off but the power LED will be green." 0 0
	[ $? -ne 0 ] && break
done

if [ "$GCW_ZERO_PRESENT" = Yes ] ; then
	while /bin/true ; do
		step_one
		RET=$?
		if [ $RET -ne 0 ] ; then
			echo "Canceled. Powering off"
			break
		fi

		while /bin/true ; do
			step_two
			RET=$?
			[ $RET -ne 2 ] && break
		done
		[ $RET -ne 0 ] && continue

		step_three
		[ $? -eq 0 ] && break
	done
fi

/sbin/poweroff
