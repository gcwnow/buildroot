#############################################################
#
# bennugd
#
#############################################################

#BENNUGD_SITE = https://bennugd.svn.sourceforge.net/svnroot/bennugd/
#BENNUGD_SITE_METHOD = svn
#BENNUGD_VERSION = 319

BENNUGD_VERSION = master
BENNUGD_SITE = git://github.com/gromv/bennugd_cmake.git
BENNUGD_DEPENDENCIES = libpng sdl sdl_mixer openssl
BENNUGD_INSTALL_TARGET = YES

$(eval $(cmake-package))