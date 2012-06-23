#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

RSA_KEY=/etc/dropbear/dropbear_rsa_host_key
DSS_KEY=/etc/dropbear/dropbear_dss_host_key

# Exit if the keys are already present
[ -r $RSA_KEY ] && [ -r $DSS_KEY ] && exit 0

echo -n "generating rsa key... "
/usr/bin/dropbearkey -t rsa -f $RSA_KEY > /dev/null 2>&1
echo "done"

echo -n "generating dsa key... "
/usr/bin/dropbearkey -t dss -f $DSS_KEY > /dev/null 2>&1
echo "done"
