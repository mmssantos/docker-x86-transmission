#!/bin/sh

set -e
SETTINGS_BASE=/transmission/settings.json
SETTINGS_LIVE=/etc/transmission-daemon/settings.json

if [[ ! -f ${SETTINGS}.bak ]]; then
  cp $SETTINGS_BASE $SETTINGS_LIVE

  # Checks for USERNAME variable
  if [ -z "$USERNAME" ]; then
    echo >&2 'Please set an USERNAME variable (ie.: -e USERNAME=john).'
    exit 1
  fi
  # Checks for PASSWORD variable
  if [ -z "$PASSWORD" ]; then
    echo >&2 'Please set a PASSWORD variable (ie.: -e PASSWORD=hackme).'
     exit 1
  fi
  # Modify settings.json
  sed -i.bak -e "s/#rpc-password#/$PASSWORD/" $SETTINGS_LIVE
  sed -i.bak -e "s/#rpc-username#/$USERNAME/" $SETTINGS_LIVE
fi

unset PASSWORD USERNAME

exec /usr/bin/transmission-daemon --foreground --config-dir /etc/transmission-daemon
