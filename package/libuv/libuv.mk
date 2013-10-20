################################################################################
#
# libuv
#
################################################################################

LIBUV_VERSION := v0.11.13
LIBUV_SITE := git://github.com/joyent/libuv.git
LIBUV_INSTALL_STAGING := YES
LIBUV_AUTORECONF := YES

$(eval $(autotools-package))
