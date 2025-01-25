#!/usr/bin/with-contenv bashio

ulimit -n 1048576

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"
mount --bind /data/cups/cupsd.conf /etc/cups/cupsd.conf || echo || dmesg

bashio::log.info "Starting CUPS server as CMD from S6"

cupsd -f
