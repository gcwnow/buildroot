################################################################################
#
# libglog
#
################################################################################

LIBGLOG_VERSION		= 0.3.3
LIBGLOG_SITE		= http://google-glog.googlecode.com/files/
LIBGLOG_SOURCE		= glog-${LIBGLOG_VERSION}.tar.gz
LIBGLOG_LICENSE		= BSD-3c
LIBGLOG_LICENSE_FILES	= COPYING
LIBGLOG_INSTALL_STAGING	= YES

$(eval $(autotools-package))
