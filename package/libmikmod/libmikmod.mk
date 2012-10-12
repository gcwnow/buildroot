#############################################################
#
# libmikmod
#
#############################################################
LIBMIKMOD_VERSION:=3.2.0
LIBMIKMOD_SITE:=http://mikmod.shlomifish.org/files

LIBMIKMOD_CONF_OPT = --localstatedir=/var \
		--disable-esd

LIBMIKMOD_LIBTOOL_PATCH = NO
LIBMIKMOD_INSTALL_STAGING = YES

$(eval $(autotools-package))
