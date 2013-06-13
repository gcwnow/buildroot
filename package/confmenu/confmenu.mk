#############################################################
#
# confmenu
#
#############################################################
CONFMENU_VERSION = master
CONFMENU_SITE = git://github.com/pcercuei/confmenu.git
CONFMENU_DEPENDENCIES = libcmenu sdl sdl_image libxml2

CONFMENU_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" \
				  LDFLAGS="$(TARGET_LDFLAGS)" \
				  CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr

define CONFMENU_BUILD_CMDS
	$(CONFMENU_MAKE_ENV) $(MAKE) -C $(@D)
endef

define CONFMENU_INSTALL_TARGET_CMDS
	$(CONFMENU_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
