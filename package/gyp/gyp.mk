################################################################################
#
# gyp
#
################################################################################

GYP_VERSION := HEAD
GYP_SITE := http://gyp.googlecode.com/svn/trunk/
GYP_SITE_METHOD := svn

HOST_GYP_DEPENDENCIES := host-python

define HOST_GYP_INSTALL_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py install \
		--prefix=$(HOST_DIR)/usr)
	$(INSTALL) -m 0755 $(@D)/gyp_main.py \
		$(HOST_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/gyp_main.py
endef

$(eval $(host-generic-package))
