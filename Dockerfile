FROM ubuntu:14.04
MAINTAINER Ryan Barber <ryan.barber@gmail.com>

# Get puppet repos
RUN sudo apt-get install -y curl &&\
    curl -o /root/puppet-repo.deb -s https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb &&\
    dpkg -i /root/puppet-repo.deb && rm /root/puppet-repo.deb

RUN apt-get update && apt-get install -y \
  puppetserver 

# expose puppet
EXPOSE 8140

CMD ["/opt/puppetlabs/bin/puppetserver", "foreground"]
