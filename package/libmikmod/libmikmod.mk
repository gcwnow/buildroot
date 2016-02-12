#############################################################
#
# libmikmod
#
#############################################################
LIBMIKMOD_VERSION:=3.3.6
LIBMIKMOD_SITE:=http://sourceforge.net/projects/mikmod/files/libmikmod/$(LIBMIKMOD_VERSION)

LIBMIKMOD_CONF_OPT = --localstatedir=/var \
		--disable-esd

LIBMIKMOD_LIBTOOL_PATCH = NO
LIBMIKMOD_INSTALL_STAGING = YES

# Fixup prefix= and exec_prefix= in libmikmod-config
define LIBMIKMOD_FIXUP_LIBMIKMOD_CONFIG
	$(SED) 's%prefix=/usr%prefix=$(STAGING_DIR)/usr%' \
		$(STAGING_DIR)/usr/bin/libmikmod-config
	$(SED) 's%exec_prefix=/usr%exec_prefix=$(STAGING_DIR)/usr%' \
		$(STAGING_DIR)/usr/bin/libmikmod-config
endef

define LIBMIKMOD_REMOVE_LIBMIKMOD_CONFIG
rm -f $(TARGET_DIR)/usr/bin/libmikmod-config
endef

LIBMIKMOD_POST_INSTALL_STAGING_HOOKS+=LIBMIKMOD_FIXUP_LIBMIKMOD_CONFIG
LIBMIKMOD_POST_INSTALL_TARGET_HOOKS += LIBMIKMOD_REMOVE_LIBMIKMOD_CONFIG

$(eval $(autotools-package))
