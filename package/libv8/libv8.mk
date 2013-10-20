################################################################################
#
# libv8
#
################################################################################

LIBV8_VERSION := 3.22.15
LIBV8_SITE := git://github.com/v8/v8.git
LIBV8_INSTALL_STAGING := YES

LIBV8_DEPENDENCIES := host-python host-gyp

ifeq ($(BR2_PACKAGE_READLINE),y)
	LIBV8_DEPENDENCIES += readline
	LIBV8_WITH_READLINE="-Dconsole=readline"
endif

LIBV8_MAKE_ENV := CC=$(TARGET_CC) CXX=$(TARGET_CXX) LINK=$(TARGET_CXX) \
	AR=$(TARGET_AR) CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

ifeq ($(BR2_PACKAGE_LIBV8_INSTALL_RUNTIME),y)
define LIBV8_INSTALL_RUNTIME
	$(INSTALL) -m 0755 $(@D)/out/Release/d8 $(TARGET_DIR)/usr/bin/d8
endef

	LIBV8_POST_INSTALL_TARGET_HOOKS += LIBV8_INSTALL_RUNTIME
endif

define LIBV8_CONFIGURE_CMDS
	( cd $(@D) ; \
		PYTHONPATH="$(@D)/tools/generate_shim_headers:" GYP_GENERATORS=make \
		$(LIBV8_MAKE_ENV) $(HOST_DIR)/usr/bin/python \
		$(HOST_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/gyp_main.py \
		--ignore-environment \
		--generator-output="out" build/all.gyp -Ibuild/standalone.gypi \
		--depth=. -Dv8_target_arch=$(BR2_ARCH) -S.$(BR2_ARCH) \
		-Dcomponent=shared_library $(LIBV8_WITH_READLINE) \
		-Dv8_enable_backtrace=1 -Dv8_enable_i18n_support=0 -Dwerror='' )
endef

define LIBV8_BUILD_CMDS
	$(LIBV8_MAKE_ENV) $(MAKE) -C $(@D)/out -f Makefile.$(BR2_ARCH) \
		BUILDTYPE=Release builddir=$(@D)/out/Release
endef

define LIBV8_INSTALL_STAGING_CMDS
	$(INSTALL) -m 0644 $(@D)/out/Release/lib.target/libv8.so \
		$(STAGING_DIR)/usr/lib/libv8.so.$(LIBV8_VERSION)
	$(INSTALL) -m 0644 $(@D)/include/v8.h $(@D)/include/v8config.h \
		$(@D)/include/v8-debug.h $(@D)/include/v8-defaults.h \
		$(@D)/include/v8-profiler.h $(@D)/include/v8stdint.h \
		$(@D)/include/v8-testing.h $(STAGING_DIR)/usr/include/
endef

define LIBV8_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 $(@D)/out/Release/lib.target/libv8.so \
		$(TARGET_DIR)/usr/lib/libv8.so.$(LIBV8_VERSION)
endef

$(eval $(generic-package))
