################################################################################
#
# sdl2
#
################################################################################

SDL2_VERSION = master
SDL2_SITE = git://github.com/pcercuei/SDL2/
SDL2_LICENSE = zlib
SDL2_LICENSE_FILES = COPYING.txt
SDL2_INSTALL_STAGING = YES

SDL2_CONF_OPT += --enable-video-fbdev \
				 $(if $(BR2_PACKAGE_HAS_OPENGL_ES), $(LIBGLES_DEPENDENCIES)) \
				 $(if $(BR2_PACKAGE_HAS_OPENGL_EGL), $(LIBEGL_DEPENDENCIES)) \
				 $(if $(BR2_PACKAGE_PULSEAUDIO), pulseaudio)

ifeq ($(BR2_PACKAGE_DIRECTFB),y)
SDL2_DEPENDENCIES += directfb
SDL2_CONF_OPT += --enable-video-directfb
SDL2_CONF_ENV = ac_cv_path_DIRECTFBCONFIG=$(STAGING_DIR)/usr/bin/directfb-config
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SDL2_DEPENDENCIES += alsa-lib
SDL2_CONF_OPT += --enable-alsa --enable-oss=no
endif

ifeq ($(BR2_PACKAGE_TSLIB),y)
# OpenDingux hack: We've got tslib to make porting easier, but we've got no
#                  touch screen, so having SDL try to use tslib is pointless.
#SDL_DEPENDENCIES += tslib
SDL2_CONF_OPT+=--enable-input-tslib=no
endif

# Remove the -Wl,-rpath option.
define SDL2_FIXUP_SDL2_CONFIG
	$(SED) 's%-Wl,-rpath,\$${libdir}%%' \
		$(STAGING_DIR)/usr/bin/sdl2-config
endef

define SDL2_REMOVE_SDL2_CONFIG
	rm $(TARGET_DIR)/usr/bin/sdl2-config
endef

SDL2_POST_INSTALL_STAGING_HOOKS += SDL2_FIXUP_SDL2_CONFIG
SDL2_POST_INSTALL_TARGET_HOOKS += SDL2_REMOVE_SDL2_CONFIG

$(eval $(autotools-package))
