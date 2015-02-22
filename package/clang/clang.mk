################################################################################
#
# clang
#
################################################################################

CLANG_VERSION = 3.5.1
CLANG_SITE = http://llvm.org/releases/$(CLANG_VERSION)
CLANG_SOURCE = cfe-$(CLANG_VERSION).src.tar.xz
CLANG_LICENSE = University of Illinois/NCSA Open Source License
CLANG_LICENSE_FILES = LICENSE.TXT

HOST_CLANG_DEPENDENCIES = host-binutils host-llvm host-libxml2

HOST_CLANG_BUILDDIR = $(HOST_CLANG_SRCDIR)/build

define HOST_CLANG_CREATE_BUILD_SUBDIR
mkdir -p $(HOST_CLANG_BUILDDIR)
endef
HOST_CLANG_PRE_CONFIGURE_HOOKS += HOST_CLANG_CREATE_BUILD_SUBDIR

LLVM_EXE_PREFIX = $(HOST_DIR)/usr/bin/$(GNU_TARGET_NAME)-llvm

# XXX: libxml2 detection is broken in cmake
HOST_CLANG_CONF_OPT = -DLLVM_CONFIG=$(LLVM_EXE_PREFIX)-config \
					  -DLLVM_TABLEGEN_EXE=$(LLVM_EXE_PREFIX)-tblgen \
					  -DDEFAULT_SYSROOT=$(STAGING_DIR) \
					  -DGCC_INSTALL_PREFIX=$(HOST_DIR)/usr \
					  -DLIBXML2_INCLUDE_DIR=$(HOST_DIR)/usr/include/libxml2 \
					  -DLIBXML2_LIBRARIES=$(HOST_DIR)/usr/lib/libxml2.so

$(eval $(host-cmake-package))
