#############################################################
#
# libmodplug
#
#############################################################
LIBMODPLUG_VERSION = 0.8.8.4
LIBMODPLUG_SITE = http://downloads.sourceforge.net/project/modplug-xmms/libmodplug/$(LIBMODPLUG_VERSION)

LIBMODPLUG_INSTALL_STAGING = YES

$(eval $(autotools-package))
