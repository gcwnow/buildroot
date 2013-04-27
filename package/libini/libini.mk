#############################################################
#
# libini
#
#############################################################
LIBINI_VERSION = master
LIBINI_SITE = git://github.com/pcercuei/libini.git
LIBINI_INSTALL_STAGING = YES

LIBINI_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
				  CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr

define LIBINI_BUILD_PYTHON
	(cd $(@D)/python ; $(HOST_DIR)/usr/bin/python setup.py build)
endef
define LIBINI_INSTALL_PYTHON
	(cd $(@D)/python ; $(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr)
endef

ifeq ($(BR2_PACKAGE_PYTHON),y)
	LIBINI_DEPENDENCIES += python host-python
	LIBINI_POST_BUILD_HOOKS += LIBINI_BUILD_PYTHON
	LIBINI_POST_INSTALL_TARGET_HOOKS += LIBINI_INSTALL_PYTHON
endif

define LIBINI_BUILD_CMDS
	$(LIBINI_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBINI_INSTALL_STAGING_CMDS
	$(LIBINI_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBINI_INSTALL_TARGET_CMDS
	$(LIBINI_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

define LIBINI_UNINSTALL_STAGING_CMDS
	$(LIBINI_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) uninstall
endef

define LIBINI_UNINSTALL_TARGET_CMDS
	$(LIBINI_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) uninstall
endef

$(eval $(generic-package))
