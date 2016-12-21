FROM ubuntu:16.04

ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

LABEL org.label-schema.vendor="Puppet" \
 org.label-schema.name="Puppet Server" \
 org.label-schema.version="2.7.2"

RUN apt-get update && \
 apt-get -y install wget && \
 apt-get -y install apt-utils && \
 wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb && \
 dpkg -i puppetlabs-release-pc1-xenial.deb && \
 rm -f puppetlabs-release-pc1-xenial.deb && \
 apt-get update && \
 apt-get -y install puppetserver=2.7.2-1puppetlabs1 && \
 apt-get clean autoclean && \
 apt-get autoremove -y
 
RUN echo "export PS1='\e[1;33m[\u@\h:\w]\$\e[m '" >> ~/.bashrc && \
 rm --force --recursive /etc/puppetlabs && \
 install -d -o root -g root -m 777 /local/puppet/puppetlabs && \
 ln -s -t /etc /local/puppet/puppetlabs && \
 install -d -o puppet -g puppet -m 771 /etc/puppetlabs-ssl
 
EXPOSE 8140

ENTRYPOINT [ "puppet", "master", "--no-daemonize", "--verbose" ]