#!/usr/bin/with-contenv bashio

ulimit -n 1048576

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"
cp -v -R /etc/cups /data
rm -v -fR /etc/cups
rm -f /data/cups/cupsd.conf
cp /config/cupsd.conf /data/cups/cupsd.conf
ln -v -s /data/cups /etc/cups
bashio::log.info "Starting CUPS server as CMD from S6"

ln -v -s /data/spool/cups /var/spool/cups

ln -v -s /data /config/cups_data

cupsd -f #-c /config/cupsd.conf
