#############################################################
#
# libopk
#
#############################################################
LIBOPK_VERSION = master
LIBOPK_SITE = git://github.com/gcwnow/libopk.git
LIBOPK_DEPENDENCIES = zlib lzo
LIBOPK_INSTALL_STAGING = YES

LIBOPK_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
				  CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr

define LIBOPK_BUILD_CMDS
	$(LIBOPK_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBOPK_INSTALL_STAGING_CMDS
	$(LIBOPK_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBOPK_INSTALL_TARGET_CMDS
	$(LIBOPK_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))
