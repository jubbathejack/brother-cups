#/bin/bash -e

echo -e "${ADMIN_PASSWD}\n${ADMIN_PASSWD}" | passwd admin

if [ ! -f /etc/cups/cupsd.conf ]; then
  cp -rpn /etc/cups-skel/* /etc/cups/
fi

exec "$@"
