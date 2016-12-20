FROM ubuntu:16.04

ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.name="Puppet Server" \
      org.label-schema.version="2.7.2" \
      com.puppet.dockerfile="/Dockerfile"

RUN apt-get update && \
 apt-get -y install wget && \
 wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && \
 dpkg -i puppetlabs-release-pc1-xenial.deb && \
 rm -f puppetlabs-release-pc1-xenial.deb && \
 apt-get update && \
 apt-get -y install puppetserver=2.7.2-1puppetlabs1 && \
 apt-get clean autoclean && \
 apt-get autoremove -y && \
 rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
 puppet config set autosign true --section puppetmaster && \
 puppet config set ca_name puppetmaster --section main && \
 puppet config set codedir /local/puppet/puppetlabs/code --section main && \
 puppet config set confdir /local/puppet/puppetlabs/puppet --section main && \
 puppet config set config /local/puppet/puppetlabs/puppet/puppet.conf --section main
 
COPY Dockerfile /

EXPOSE 8140

ENTRYPOINT [ "puppet", "master", "--no-daemonize", "--verbose" ]