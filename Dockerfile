FROM braverbinaryarts/baseimage:0.9.17
MAINTAINER Ryan Barber <ryan.barber@gmail.com>

# Set up default ENV variables
ENV PUPPETMASTER_HOSTNAME puppetmaster01
ENV PUPPETMASTER_DOMAIN example.com
ENV PUPPETMASTER_ALT_NAMES puppet,puppet.example.com,puppetmaster01
ENV PUPPET_CONF_FILE /etc/puppetlabs/puppet/puppet.conf

# Get puppet repos
RUN curl -o /root/puppet-repo.deb -s https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb &&\
    dpkg -i /root/puppet-repo.deb && rm /root/puppet-repo.deb

# Install puppetserver
RUN apt-get update && apt-get install -y \
  puppetserver 

# expose puppet
EXPOSE 8140

# Define puppet as a service for phusion baseimage
RUN mkdir /etc/service/puppetmaster
ADD scripts/puppetmaster.sh /etc/service/puppetmaster/run
ADD configs/defaults/puppetmaster /etc/defaults/puppetmaster

# Copy init scripts to /etc/my_init.d
COPY scripts/my_init.d/* /etc/my_init.d

VOLUMES["/opt/puppetlabs/storage"]

# Launch baseimage init.
CMD ["/sbin/my_init"]
