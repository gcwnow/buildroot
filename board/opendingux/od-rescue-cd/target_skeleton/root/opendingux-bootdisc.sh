#!/bin/sh

cd /root

# Version of this script
VERSION=0.1

export TERM="linux"
export DIALOGOPTS="--colors --backtitle \"OpenDingux Rescue Disc v${VERSION}\""
echo "screen_color = (RED,RED,ON)" > /tmp/dialog_err.rc

CONFIG=""
FLASH_MBR=Yes
FLASH_BOOTLOADER=Yes
FLASH_SYSTEM=Yes
FLASH_DATA=No

step_one() {
	RETAIL=""
	PROTO2=""
	PROTO1=""
	[ "$CONFIG" = "Retail unit" ] && RETAIL=on
	[ "$CONFIG" = "512MiB Prototype" ] && PROTO2=on
	[ "$CONFIG" = "256MiB Prototype" ] && PROTO1=on
	[ -z "$RETAIL" -a -z "$PROTO2" -a -z "$PROTO1" ] && RETAIL=on

	CONFIG=$( \
		exec 3>&1 ; \
		/usr/bin/dialog --output-fd 3 --cancel-label "Power off" --radiolist \
		"Please select the configuration corresponding to the GCW-Zero unit:" 0 0 0 \
		"Retail unit" "SE, KickStarter or regular edition" "$RETAIL" \
		"512MiB Prototype" "Second-gen 512MiB RAM prototype" "$PROTO2" \
		"256MiB Prototype" "First-gen 256MiB RAM prototype" "$PROTO1" \
		3>&1 >&2 ; 3>&- )

	[ -z "$CONFIG" ] && return 1
	return 0
}

step_two() {
	MBR=""
	BOOTLOADER=""
	SYSTEM=""
	DATA=""
	[ $FLASH_MBR = Yes ] && MBR=on
	[ $FLASH_BOOTLOADER = Yes ] && BOOTLOADER=on
	[ $FLASH_SYSTEM = Yes ] && SYSTEM=on
	[ $FLASH_DATA = Yes ] && DATA=""

	while /bin/true ; do
		RESULT=$( \
			exec 3>&1 ; \
			/usr/bin/dialog --output-fd 3 --cancel-label "Back" \
			--separate-output --checklist \
			"Select what you want to flash." 0 0 0 \
			"MBR" "Flash the partition table" "$MBR" \
			"Bootloader" "Flash the bootloader" "$BOOTLOADER" \
			"System" "Flash the system partition" "$SYSTEM" \
			"Data" "\Zb\Z1Flash the data partition /!\\\Zn" "$DATA" \
			3>&1 >&2 ; 3>&- )
		[ -z "$RESULT" ] && return 1

		FLASH_MBR=No
		FLASH_BOOTLOADER=No
		FLASH_SYSTEM=No
		FLASH_DATA=No

		PARAMS=''
		for each in $RESULT ; do
			if [ $each = 'MBR' ] ; then
				FLASH_MBR=Yes
			elif [ $each = 'Bootloader' ] ; then
				FLASH_BOOTLOADER=Yes
			elif [ $each = 'System' ] ; then
				FLASH_SYSTEM=Yes
			elif [ $each = "Data" ] ; then
				/usr/bin/dialog --defaultno --yesno \
					"\Zb\Z1WARNING: Reflashing the data partition will irremediably wipe all your data.\nDo you want to continue?\Zn" 0 0
				[ $? -ne 0 ] && return 2
				FLASH_DATA=Yes
			fi
		done

		[ $FLASH_MBR = Yes -o $FLASH_BOOTLOADER = Yes -o $FLASH_SYSTEM = Yes -o $FLASH_DATA = Yes ] && break
	done
	return 0
}


step_three() {
	/usr/bin/dialog --defaultno --yes-label "Flash!" --no-label "Back" \
		--yesno "This is the configuration you selected:\n
*   GCW-Zero model:         \Zb\Z1$CONFIG\Zn\n
*   Flash MBR:              \Zb\Z1$FLASH_MBR\Zn\n
*   Flash Bootloader:       \Zb\Z1$FLASH_BOOTLOADER\Zn\n
*   Flash System partition: \Zb\Z1$FLASH_SYSTEM\Zn\n
*   Flash Data partition:   \Zb\Z1$FLASH_DATA\Zn\n\n
Do you want to flash now?" 0 0
	[ $? -ne 0 ] && return 1

	CONFIG2=""
	if [ "$CONFIG" = "Retail unit" ] ; then
		CONFIG2="v20_mddr_512mb"
	elif [ "$CONFIG" = "512MiB Prototype" ] ; then
		CONFIG2="v11_ddr2_512mb"
	elif [ "$CONFIG" = "256MiB Prototype" ] ; then
		CONFIG2="v11_ddr2_256mb"
	fi

	COMMAND="./ingenic-boot --config=gcw0_${CONFIG2}"
	[ $FLASH_MBR = Yes ] && COMMAND="$COMMAND --mbr=images/mbr.bin"
	[ $FLASH_BOOTLOADER = Yes ] && COMMAND="$COMMAND --boot=images/ubiboot-${CONFIG2}.bin"
	[ $FLASH_SYSTEM = Yes ] && COMMAND="$COMMAND --system=images/system.bin"
	[ $FLASH_DATA = Yes ] && COMMAND="$COMMAND --data=images/data.bin"

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

	./ingenic-boot --probe >/dev/null 2>&1
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
