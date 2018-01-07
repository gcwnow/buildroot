################################################################################
#
# libglog
#
################################################################################

LIBGLOG_VERSION		= 0.3.5
LIBGLOG_SITE		= https://github.com/google/glog/archive/
LIBGLOG_SOURCE		= v${LIBGLOG_VERSION}.tar.gz
LIBGLOG_LICENSE		= BSD-3c
LIBGLOG_LICENSE_FILES	= COPYING
LIBGLOG_INSTALL_STAGING	= YES

$(eval $(autotools-package))
