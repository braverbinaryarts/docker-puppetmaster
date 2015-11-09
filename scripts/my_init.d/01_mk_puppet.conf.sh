#!/usr/bin/env bash
# Look here.
# We get these environment variables from docker

if [ -x $PUPPET_CONF_FILE ]; then
  if grep "dns_alt_names" $PUPPET_CONF_FILE; then
    echo "*** puppet.conf already exists and has dns_alt_names"
    exit
  fi
fi

echo -n "[main]
certname             = " > $PUPPET_CONF_FILE
echo "${PUPPETMASTER_HOSTNAME}.${PUPPETMASTER_DOMAIN}" >> $PUPPET_CONF_FILE
echo -n "server               = puppet
environment          = production
strict_variables     = true

[master]
dns_alt_names        = " >> $PUPPET_CONF_FILE
echo $PUPPETMASTER_ALT_NAMES >> $PUPPET_CONF_FILE
echo "environment_timeout  = unlimited
vardir               = /opt/puppetlabs/storage/data/puppetserver
logdir               = /opt/puppetlabs/storage/var/log
rundir               = /opt/puppetlabs/storage/var/run
pidfile              = /opt/puppetlabs/storage/var/run/puppetserver.pid
codedir              = /opt/puppetlabs/storage/code" >> $PUPPET_CONF_FILE

echo "*** prepared new puppet.conf for this container"
