#############################################################
#
# bennugd
#
#############################################################

#BENNUGD_SITE = https://bennugd.svn.sourceforge.net/svnroot/bennugd/
#BENNUGD_SITE_METHOD = svn
#BENNUGD_VERSION = 319

BENNUGD_VERSION = master
BENNUGD_SITE = git://github.com/gromv/bennugd.git

BENNUGD_DEPENDENCIES = libpng sdl sdl_mixer openssl

define BENNUGD_BUILD_CMDS
        #chmod +x $(@D)/core/configure
        #chmod +x $(@D)/modules/configure
        #chmod +x $(@D)/tools/moddesc/configure
        (cd $(@D); export TARGET=mipsel-gcw0-linux-uclibc; ./build-buildroot.sh release)
endef

define BENNUGD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/mipsel-gcw0-linux-uclibc/bgdi $(TARGET_DIR)/usr/bin/.
        $(INSTALL) -D -m 0755 $(@D)/bin/mipsel-gcw0-linux-uclibc/bgdc $(TARGET_DIR)/usr/bin/.
        $(INSTALL) -D -m 0755 $(@D)/bin/mipsel-gcw0-linux-uclibc/moddesc $(TARGET_DIR)/usr/bin/.
        $(INSTALL) -D -m 0755 $(@D)/bin/mipsel-gcw0-linux-uclibc/*.so $(TARGET_DIR)/usr/lib/.
endef

$(eval $(generic-package))
