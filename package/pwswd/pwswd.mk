#############################################################
#
# pwswd
#
#############################################################
PWSWD_VERSION = master
PWSWD_SITE = git://github.com/pcercuei/pwswd.git
PWSWD_DEPENDENCIES = alsa-lib libpng

define PWSWD_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS) -DDEFAULT_MIXER=\\\"$(BR2_PACKAGE_PWSWD_MIXER)"\\\"
endef

define PWSWD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/pwswd $(TARGET_DIR)/usr/sbin/pwswd
	$(INSTALL) -D -m 0644 $(@D)/template.conf $(TARGET_DIR)/etc/pwswd.conf
	$(INSTALL) -D -m 0755 package/pwswd/S91pwswd.sh $(TARGET_DIR)/etc/init.d/S91pwswd.sh
endef

$(eval $(generic-package))
