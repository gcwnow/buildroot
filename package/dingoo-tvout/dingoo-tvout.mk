#############################################################
#
# dingoo-tvout
#
#############################################################
DINGOO_TVOUT_VERSION = opendingux
DINGOO_TVOUT_SITE = git://github.com/mthuurne/dingoo-tvout.git
DINGOO_TVOUT_DEPENDENCIES =

define DINGOO_TVOUT_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" -C $(@D)
endef

define DINGOO_TVOUT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/tvout $(TARGET_DIR)/usr/sbin/tvout
endef

$(eval $(call GENTARGETS))
