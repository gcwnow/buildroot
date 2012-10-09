#############################################################
#
# gmenu2x
#
#############################################################
GMENU2X_VERSION = packages
GMENU2X_SITE = git://projects.qi-hardware.com/gmenu2x.git
GMENU2X_DEPENDENCIES = sdl sdl_gfx libpng
GMENU2X_AUTORECONF = YES
GMENU2X_CONF_OPT = --with-sdl-prefix=$(STAGING_DIR)/usr --enable-platform=dingux

ifeq ($(BR2_PACKAGE_LIBOPK),y)
GMENU2X_DEPENDENCIES += libopk
endif

$(eval $(autotools-package))
