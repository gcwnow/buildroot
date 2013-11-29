################################################################################
#
# libsndfile
#
################################################################################

LIBSNDFILE_VERSION = 1.0.25
LIBSNDFILE_SITE = http://www.mega-nerd.com/libsndfile/files
LIBSNDFILE_INSTALL_STAGING = YES
LIBSNDFILE_DEPENDENCIES = host-pkgconf \
		  $(if $(BR2_PACKAGE_LIBOGG), libogg) \
		  $(if $(BR2_PACKAGE_LIBVORBIS), libvorbis) \
		  $(if $(BR2_PACKAGE_FLAC), flac) \

$(eval $(autotools-package))
