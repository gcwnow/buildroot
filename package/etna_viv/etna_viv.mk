#############################################################
#
# etna_viv
#
#############################################################
ETNA_VIV_VERSION = master
ETNA_VIV_SITE = git://github.com/laanwj/etna_viv.git
ETNA_VIV_INSTALL_STAGING = YES
# Currently, etna_viv only builds static libs, no point in installing those
# on the target.
ETNA_VIV_INSTALL_TARGET = NO

ifeq ($(BR2_PACKAGE_ETNA_VIV_ABIV2),y)
ETNA_VIV_ABI = v2
else ifeq ($(BR2_PACKAGE_ETNA_VIV_ABIV4),y)
ETNA_VIV_ABI = v4
else ifeq ($(BR2_PACKAGE_ETNA_VIV),y)
$(error No ABI version selected)
endif

define ETNA_VIV_BUILD_CMDS
	$(MAKE) -C $(@D)/native/etnaviv \
		GCCPREFIX="$(TARGET_CROSS)" \
		PLATFORM_CFLAGS="-D_POSIX_C_SOURCE=200809 -D_GNU_SOURCE -DLINUX" \
		PLATFORM_CXXFLAGS="-D_POSIX_C_SOURCE=200809 -D_GNU_SOURCE -DLINUX" \
		PLATFORM_LDFLAGS="-ldl -lpthread" \
		GCABI="$(ETNA_VIV_ABI)"
endef

define ETNA_VIV_INSTALL_STAGING_CMDS
	cp $(@D)/native/etnaviv/libetnaviv.a $(STAGING_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/etnaviv
	cp $(@D)/native/etnaviv/*.h $(STAGING_DIR)/usr/include/etnaviv
endef

$(eval $(generic-package))
