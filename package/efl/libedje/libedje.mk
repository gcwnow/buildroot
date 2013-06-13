#############################################################
#
# libedje
#
#############################################################

LIBEDJE_VERSION = 1.7.0
LIBEDJE_SOURCE = edje-$(LIBEDJE_VERSION).tar.bz2
LIBEDJE_SITE =  http://download.enlightenment.org/releases/
LIBEDJE_LICENSE = GPLv2+ (epp binary), BSD-2c (everything else)
LIBEDJE_LICENSE_FILES = COPYING
LIBEDJE_AUTORECONF = YES

LIBEDJE_INSTALL_STAGING = YES

LIBEDJE_DEPENDENCIES = host-pkgconf libeina libeet libecore libevas \
			libembryo

ifeq ($(BR2_PACKAGE_LUAJIT),y)
	LIBEDJE_DEPENDENCIES += luajit
else
	LIBEDJE_DEPENDENCIES += lua
endif

ifeq ($(BR2_PACKAGE_LIBEDJE_CC),y)
LIBEDJE_CONF_OPT += --enable-edje-cc
else
LIBEDJE_CONF_OPT += --disable-edje-cc
endif

HOST_LIBEDJE_CONF_OPT = --enable-edje-cc

$(eval $(autotools-package))
$(eval $(host-autotools-package))
