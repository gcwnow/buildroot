#############################################################
#
# libsndfile
#
#############################################################

LIBSNDFILE_VERSION = 1.0.25
LIBSNDFILE_SITE = http://www.mega-nerd.com/libsndfile/files
LIBSNDFILE_INSTALL_STAGING = YES

# We have no cross pkg-config and using the host version can cause problems.
LIBSNDFILE_CONF_ENV:=PKG_CONFIG=/do-not-use-pkg-config

$(eval $(call AUTOTARGETS))
