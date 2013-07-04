#############################################################
#
# dejavu fonts
#
#############################################################

DEJAVU_FONTS_VERSION = 2.33
DEJAVU_FONTS_SOURCE = dejavu-fonts-ttf-$(DEJAVU_FONTS_VERSION).tar.bz2
DEJAVU_FONTS_SITE = http://downloads.sourceforge.net/project/dejavu/dejavu/$(DEJAVU_FONTS_VERSION)

define DEJAVU_FONTS_INSTALL_SANS
 cp -a $(@D)/ttf/DejaVuSans*.ttf $(TARGET_DIR)/usr/share/fonts/truetype/dejavu
endef

ifeq ($(BR2_PACKAGE_DEJAVU_FONTS_SANS),y)
	DEJAVU_FONTS_POST_INSTALL_TARGET_HOOKS += DEJAVU_FONTS_INSTALL_SANS
endif

define DEJAVU_FONTS_INSTALL_SERIF
 cp -a $(@D)/ttf/DejaVuSerif*.ttf $(TARGET_DIR)/usr/share/fonts/truetype/dejavu
endef

ifeq ($(BR2_PACKAGE_DEJAVU_FONTS_SERIF),y)
	DEJAVU_FONTS_POST_INSTALL_TARGET_HOOKS += DEJAVU_FONTS_INSTALL_SERIF
endif

define DEJAVU_FONTS_INSTALL_TARGET_CMDS
 mkdir -p $(TARGET_DIR)/usr/share/fonts/truetype/dejavu
 cp -a $(@D)/LICENSE $(TARGET_DIR)/usr/share/fonts/truetype/dejavu
endef

$(eval $(generic-package))
