#!/usr/bin/env ruby
# Look here.
# We get these environment variables from docker
HOSTNAME    = ENV['PUPPETMASTER_HOSTNAME']
DOMAIN      = ENV['PUPPETMASTER_DOMAIN']
ALT_NAMES   = ENV['PUPPETMASTER_ALT_NAMES']
PUPPET_CONF = ENV['PUPPET_CONF_FILE']

# Here we check to see if we need to do this.
if !(File.exists?(PUPPET_CONF)) or !(/dns_alt_names/.match(File.read(PUPPET_CONF)))
  pconf = File.open(">#{PUPPET_CONF}")
  pconf.puts <<-EOF
[main]
certname             = #{HOSTNAME}.#{DOMAIN}
server               = puppet
environment          = production
strict_variables     = true

[master]
dns_alt_names        = #{ALT_NAMES}
environment_timeout  = unlimited
vardir               = /opt/puppetlabs/storage/data/puppetserver
logdir               = /opt/puppetlabs/storage/var/log
rundir               = /opt/puppetlabs/storage/var/run
pidfile              = /opt/puppetlabs/storage/var/run/puppetserver.pid
codedir              = /opt/puppetlabs/storage/code
  EOF
  pconf.close
  puts "*** puppet.conf prepared according to container vars"
else  
  puts "*** puppet.conf already prepared for this container"
  exit
end


