#############################################################
#
# buteo-mtp
#
#############################################################
BUTEO_MTP_VERSION = master
BUTEO_MTP_SITE = git://github.com/pcercuei/buteo-mtp.git
BUTEO_MTP_DEPENDENCIES = qt

define BUTEO_MTP_CONFIGURE_CMDS
	cd $(@D)/mts && $(QT_QMAKE)
	cd $(@D)/mts/platform/storage/simpleplugin && $(QT_QMAKE)
	cd $(@D)/service && $(QT_QMAKE)
endef

define BUTEO_MTP_BUILD_CMDS
	$(MAKE) -C $(@D)/mts
	$(MAKE) -C $(@D)/mts/platform/storage/simpleplugin
	$(MAKE) -C $(@D)/service
endef

define BUTEO_MTP_INSTALL_STAGING_CMDS
	INSTALL_ROOT=$(STAGING_DIR) $(MAKE) -C $(@D)/mts \
				 install_target install_headers
endef

define BUTEO_MTP_INSTALL_TARGET_CMDS
	INSTALL_ROOT=$(TARGET_DIR) $(MAKE) -C $(@D)/mts install_target install_data
	INSTALL_ROOT=$(TARGET_DIR) $(MAKE) -C \
				 $(@D)/mts/platform/storage/simpleplugin install_target
	INSTALL_ROOT=$(TARGET_DIR) $(MAKE) -C $(@D)/service install_target
endef

define BUTEO_MTP_CLEAN_CMDS
	$(MAKE) -C $(@D)/src clean
	$(MAKE) -C $(@D)/mts/platform/storage/simpleplugin clean
	$(MAKE) -C $(@D)/service clean
endef

$(eval $(generic-package))
