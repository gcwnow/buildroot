#############################################################
#
# fuse-zip
#
#############################################################
FUSEZIP_VERSION:=0.2.13
FUSEZIP_SOURCE:=fuse-zip-$(FUSEZIP_VERSION).tar.gz
FUSEZIP_SITE:=https://fuse-zip.googlecode.com/files/

FUSEZIP_DEPENDENCIES=libfuse libzip

define FUSEZIP_BUILD_CMDS
	CXX="$(TARGET_CXX)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
		PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig" \
		PKG_CONFIG_SYSROOT_DIR="$(STAGING_DIR)" $(MAKE) -C $(@D) all
endef

define FUSEZIP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fuse-zip $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
