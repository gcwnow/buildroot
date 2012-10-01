#############################################################
#
# expedite
#
#############################################################

EXPEDITE_VERSION = 1.7.0
EXPEDITE_SITE = http://download.enlightenment.org/releases/
EXPEDITE_DEPENDENCIES = libevas libeina libeet

$(eval $(autotools-package))
