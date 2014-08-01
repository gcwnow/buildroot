#############################################################
#
# glm
#
#############################################################
GLM_VERSION = 0.9.5.4
GLM_SITE = git://github.com/g-truc/glm.git
GLM_LICENSE = MIT
GLM_LICENSE_FILES = copying.txt
GLM_INSTALL_STAGING = YES
GLM_INSTALL_TARGET = NO

$(eval $(cmake-package))
