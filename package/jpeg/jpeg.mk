#############################################################
#
# jpeg (libraries needed by some apps)
#
#############################################################
JPEG_VERSION = 6b
JPEG_SITE = http://mthuurne.github.com/opendingux-buildroot/distfiles/
JPEG_SOURCE = jpegsrc.v$(JPEG_VERSION).tar.gz
JPEG_INSTALL_STAGING = YES
JPEG_LIBTOOL_PATCH = NO
JPEG_CONF_OPT = --without-x --enable-shared --enable-static

define JPEG_REMOVE_USELESS_TOOLS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtrans rdjpgcom wrjpgcom)
endef

JPEG_POST_INSTALL_TARGET_HOOKS += JPEG_REMOVE_USELESS_TOOLS

$(eval $(call AUTOTARGETS))
$(eval $(call AUTOTARGETS,host))
