#############################################################
#
# libeina
#
#############################################################

LIBEINA_VERSION = 1.7.0
LIBEINA_SOURCE = eina-$(LIBEINA_VERSION).tar.bz2
LIBEINA_SITE = http://download.enlightenment.org/releases/
LIBEINA_INSTALL_STAGING = YES

LIBEINA_DEPENDENCIES = host-pkg-config

$(eval $(autotools-package))
$(eval $(host-autotools-package))
