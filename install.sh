#!/bin/bash
PATTERN=s@#WORKING_DIRECTORY#@`pwd`/bin@
WORKDIR=`pwd`/bin

mkdir /var/log/dbgp
chown www-data:www-data /var/log/dbgp
chmod 775 /var/log/dbgp

chown -R www-data:www-data ${WORKDIR}
chmod 775 /var/log/dbgp

chmod ug+x ${WORKDIR}/dbgp-start.sh
chmod ug+x ${WORKDIR}/dbgp-stop.sh
chmod ug+x ${WORKDIR}/dbgp-restart.sh

sed -e ${PATTERN} `pwd`/bin/dbgp.service.template > /etc/systemd/system/dbgp.service
