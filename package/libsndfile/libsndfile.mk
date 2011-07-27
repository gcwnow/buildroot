#############################################################
#
# libsndfile
#
#############################################################

LIBSNDFILE_VERSION = 1.0.25
LIBSNDFILE_SITE = http://www.mega-nerd.com/libsndfile/files
LIBSNDFILE_INSTALL_STAGING = YES

# We have no cross pkg-config and using the host version can cause problems.
#LIBSNDFILE_CONF_ENV:=PKG_CONFIG=/do-not-use-pkg-config
# The configure script will ignore the compile and link flags we specify unless
# a working pkg-config is present, even though the output of pkg-config will
# not be used. So we give it something that is mostly harmless.
LIBSNDFILE_CONF_ENV:=PKG_CONFIG=/bin/true

ifeq ($(BR2_PACKAGE_LIBOGG),y)
LIBSNDFILE_DEPENDENCIES+=libogg
LIBSNDFILE_CONF_ENV+=OGG_CFLAGS="" OGG_LIBS="-logg"
endif
ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
LIBSNDFILE_DEPENDENCIES+=libvorbis
LIBSNDFILE_CONF_ENV+=VORBIS_CFLAGS="" VORBIS_LIBS="-lvorbis"
LIBSNDFILE_CONF_ENV+=VORBISENC_CFLAGS="" VORBISENC_LIBS="-lvorbisenc"
endif
ifeq ($(BR2_PACKAGE_FLAC),y)
LIBSNDFILE_DEPENDENCIES+=flac
LIBSNDFILE_CONF_ENV+=FLAC_CFLAGS="-I$(STAGING_DIR)/usr/include/FLAC" FLAC_LIBS="-lFLAC -lm"
endif

$(eval $(autotools-package))
