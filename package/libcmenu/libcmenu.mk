#############################################################
#
# libcmenu
#
#############################################################
LIBCMENU_VERSION = master
LIBCMENU_SITE = git://github.com/pcercuei/libcmenu.git
LIBCMENU_DEPENDENCIES = libini sdl sdl_ttf dejavu-fonts
LIBCMENU_INSTALL_STAGING = YES

LIBCMENU_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" \
				  LDFLAGS="$(TARGET_LDFLAGS)" \
				  CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr

define LIBCMENU_BUILD_CMDS
	$(LIBCMENU_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBCMENU_INSTALL_STAGING_CMDS
	$(LIBCMENU_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBCMENU_INSTALL_TARGET_CMDS
	$(LIBCMENU_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))
