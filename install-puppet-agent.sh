#!/bin/bash

echo "Install Puppet Agent..."
rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm && yum install -y puppet-agent

echo "Configure Puppet agent..."
cat > /etc/puppetlabs/puppet/puppet.conf <<EOF
[main]
server = puppetmaster.lab
EOF
echo "172.16.8.252  puppetmaster.lab" >> /etc/hosts
/opt/puppetlabs/bin/puppet ssl bootstrap