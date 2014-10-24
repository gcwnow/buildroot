################################################################################
#
# mono
#
################################################################################

MONO_VERSION = 3.10.0
MONO_SITE = http://download.mono-project.com/sources/mono/
MONO_SOURCE = mono-$(MONO_VERSION).tar.bz2
MONO_LICENSE = LGPLv2 or commercial
MONO_LICENSE_FILES = LICENSE COPYING.LIB mcs/COPYING.LIB mcs/COPYING \
	eglib/COPYING external/Newtonsoft.Json/Tools/7-zip/copying.txt
MONO_INSTALL_STAGING = YES

## Mono native

# patching configure.ac
MONO_AUTORECONF = YES

# Disable managed code (mcs folder) from building
MONO_CONF_OPT = --disable-gtk-doc \
	--with-mcs-docs=no \
	--with-moonlight=no \
	--disable-libraries \
	--with-ikvm-native=no \
	--enable-minimal=aot,profiler,debug \
	--disable-mcs-build \
	--disable-boehm

define MONO_INSTALL_LIBS
	rsync -av --exclude=*.so --exclude=*.mdb \
		$(HOST_DIR)/usr/lib/mono $(TARGET_DIR)/usr/lib/
endef

MONO_DEPENDENCIES += host-mono

MONO_POST_INSTALL_TARGET_HOOKS += MONO_INSTALL_LIBS

## Mono managed

HOST_MONO_CONF_OPT = --disable-gtk-doc \
	--with-mcs-docs=no \
	--with-moonlight=no \
	--disable-libraries \
	--with-ikvm-native=no \
	--enable-minimal=aot,profiler,debug \
	--enable-static

# These options refer to the target mono, not the host. We use the host
# only to compile libraries, then we copy them to the target.
HOST_MONO_CONF_OPT += --with-profile2=$(if $(BR2_PACKAGE_MONO_20),yes,no)
HOST_MONO_CONF_OPT += --with-profile4=$(if $(BR2_PACKAGE_MONO_40),yes,no)
HOST_MONO_CONF_OPT += --with-profile4_5=$(if $(BR2_PACKAGE_MONO_45),yes,no)

HOST_MONO_DEPENDENCIES = host-monolite

define HOST_MONO_SETUP_MONOLITE
	rm -rf $(@D)/mcs/class/lib/monolite
	(cd $(@D)/mcs/class/lib; ln -s $(HOST_DIR)/usr/lib/monolite monolite)
endef

HOST_MONO_POST_CONFIGURE_HOOKS += HOST_MONO_SETUP_MONOLITE

$(eval $(autotools-package))
$(eval $(host-autotools-package))
