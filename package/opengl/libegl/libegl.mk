################################################################################
#
# libegl
#
################################################################################

LIBEGL_SOURCE =

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
LIBEGL_DEPENDENCIES += rpi-userland
endif

ifeq ($(BR2_PACKAGE_TI_GFX),y)
LIBEGL_DEPENDENCIES += ti-gfx
endif

ifeq ($(BR2_PACKAGE_SUNXI_MALI),y)
LIBEGL_DEPENDENCIES += sunxi-mali
endif

ifeq ($(BR2_PACKAGE_GPU_VIV_BIN_MX6Q),y)
LIBEGL_DEPENDENCIES += gpu-viv-bin-mx6q
endif

ifeq ($(BR2_PACKAGE_MESA3D_ETNA_VIV_EGL),y)
LIBEGL_DEPENDENCIES += mesa3d-etna_viv
endif

ifeq ($(LIBEGL_DEPENDENCIES),)
define LIBEGL_CONFIGURE_CMDS
	echo "No libEGL implementation selected. Configuration error."
	exit 1
endef
endif

$(eval $(generic-package))
