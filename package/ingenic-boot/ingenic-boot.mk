################################################################################
#
# ingenic-boot
#
################################################################################

INGENIC_BOOT_VERSION:= master
INGENIC_BOOT_SITE := git://github.com/gcwnow/ingenic-boot.git
INGENIC_BOOT_DEPENDENCIES := libusb-compat libconfuse

INGENIC_BOOT_MAKE_ENV := CROSS_COMPILE=$(TARGET_CROSS) \
	$(if $(BR2_PREFER_STATIC_LIB),STATIC=1)

define INGENIC_BOOT_BUILD_CMDS
	$(INGENIC_BOOT_MAKE_ENV) $(MAKE1) -C $(@D)
endef

define INGENIC_BOOT_INSTALL_TARGET_CMDS
	$(INGENIC_BOOT_MAKE_ENV) $(MAKE1) -C $(@D) \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
