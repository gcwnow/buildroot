################################################################################
#
# llvm
#
################################################################################

LLVM_VERSION = 3.5.1
LLVM_SITE = http://llvm.org/releases/$(LLVM_VERSION)
LLVM_SOURCE = llvm-$(LLVM_VERSION).src.tar.xz
LLVM_LICENSE = University of Illinois/NCSA Open Source License
LLVM_LICENSE_FILES = LICENSE.TXT

HOST_LLVM_DEPENDENCIES = host-libxml2 host-zlib host-python

ENABLED_TARGETS := $(ARCH),$(if $(BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_R600),r600)

HOST_LLVM_CONF_OPT = --with-default-sysroot=$(STAGING_DIR) \
					 --enable-bindings=none \
					 --enable-targets=$(ENABLED_TARGETS) \
					 --target=$(GNU_TARGET_NAME)

$(eval $(host-autotools-package))
