#############################################################
#
# libao
#
#############################################################

LIBAO_VERSION = 1.1.0
LIBAO_SITE = http://downloads.xiph.org/releases/ao
LIBAO_DEPENDENCIES = host-pkg-config
LIBAO_INSTALL_STAGING = YES
LIBAO_CONF_OPT = --disable-esd --disable-wmm --disable-arts \
			--disable-nas --disable-pulse

define LIBAO_REMOVE_OSS_PLUGIN
	rm -f $(TARGET_DIR)/usr/lib/ao/plugins-4/liboss.so
endef

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
LIBAO_DEPENDENCIES += alsa-lib
LIBAO_CONF_OPT += --enable-alsa --enable-alsa-mmap
LIBAO_POST_INSTALL_TARGET_HOOKS += LIBAO_REMOVE_OSS_PLUGIN
else
LIBAO_CONF_OPT += --disable-alsa
endif

$(eval $(autotools-package))
