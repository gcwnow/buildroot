################################################################################
#
# libmtpserver
#
################################################################################

LIBMTPSERVER_VERSION = 65
LIBMTPSERVER_SITE = https://launchpad.net/mtp
LIBMTPSERVER_SITE_METHOD = bzr
LIBMTPSERVER_DEPENDENCIES = boost libglog

LIBMTPSERVER_INSTALL_STAGING = YES

$(eval $(cmake-package))
