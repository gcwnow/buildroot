
ALSA_VOLUME_DIR=$(BUILD_DIR)/alsa-volume

ALSA_VOLUME_DEPENDENCIES += alsa-lib

$(ALSA_VOLUME_DIR)/getvolume.c:
	rm -rf $(ALSA_VOLUME_DIR)
	mkdir $(ALSA_VOLUME_DIR)
	cp package/multimedia/alsa-volume/getvolume.c $(ALSA_VOLUME_DIR)

$(ALSA_VOLUME_DIR)/alsa-getvolume: $(ALSA_VOLUME_DIR)/getvolume.c
	$(TARGET_CC) $(TARGET_CFLAGS) -s -lasound $(ALSA_VOLUME_DIR)/getvolume.c -o $@

$(TARGET_DIR)/usr/bin/alsa-getvolume: $(ALSA_VOLUME_DIR)/alsa-getvolume
	$(INSTALL) -m 755 $^ $@

alsa-getvolume: $(TARGET_DIR)/usr/bin/alsa-getvolume
alsa-getvolume-source:

alsa-setvolume:
alsa-setvolume-source:

alsa-volume: $(ALSA_VOLUME_DEPENDENCIES) alsa-getvolume alsa-setvolume
alsa-volume-source: alsa-getvolume-source alsa-setvolume-source

ifeq ($(BR2_PACKAGE_ALSA_VOLUME),y)
TARGETS += alsa-volume
endif
