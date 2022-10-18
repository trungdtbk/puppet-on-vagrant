#!/bin/bash

echo "Install Puppet Master..."
rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm && yum install -y puppetserver

echo "Configure JVM memory allocation..."
sed -i 's/Xms2g/Xms512m/g' /etc/sysconfig/puppetserver
sed -i 's/Xmx2g/Xmx512m/g' /etc/sysconfig/puppetserver

echo "Configure Puppet..."
cat > /etc/puppetlabs/puppet/puppet.conf <<EOF
[server]
vardir = /opt/puppetlabs/server/data/puppetserver
logdir = /var/log/puppetlabs/puppetserver
rundir = /var/run/puppetlabs/puppetserver
pidfile = /var/run/puppetlabs/puppetserver/puppetserver.pid
codedir = /etc/puppetlabs/code
autosign = true

[agent]
server = puppetmaster.lab
EOF

echo "Start Puppet master ..."
systemctl enable puppetserver
systemctl start puppetserver

echo "Install Vim and Git..."
yum install -y vim git

echo "Setting up GEM and install r10k..."
echo "export PATH=$PATH:/opt/puppetlabs/puppet/bin/" > /etc/profile.d/puppet.sh
/opt/puppetlabs/puppet/bin/gem install r10k

control_repo="$1"
echo "Set up r10k control repo to $control_repo..."
mkdir -p /etc/puppetlabs/r10k
cat > /etc/puppetlabs/r10k/r10k.yaml <<EOF
---
# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'

# A list of git repositories to create
:sources:
  # This will clone the git repository and instantiate an environment per
  # branch in /etc/puppetlabs/code/environments
  :my-org:
    remote: "$control_repo"
    basedir: '/etc/puppetlabs/code/environments'
EOF