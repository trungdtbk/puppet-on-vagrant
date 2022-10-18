# Vagrant Puppet Lab

A Puppet lab for hands-on practice with Vagrant

# Prerequisites

To create VMs with vagrant, you need to install:
- Vagrant (This project is tested on Vagrant 2.2.19)
- Virtualbox (This project is tested on Virtualbox 6.1.34)
- Install vbox plugin: `vagrant plugin install vagrant-vbguest --plugin-version 0.21`

# Usage

Open Vagrantfile and modify NUM_AGENTS to change the number of agent VMs. Modify 
CONTROL_REPO to your own github repository.

To create VMs and bootstrap your Puppet master and several agents

`vagrant up`

After creation of VMs is complete ssh into Puppet master:

```
vagrant ssh puppetmaster.lab
sudo su -
puppet agent -t
```

Login to Puppet agent:
```
vagrant ssh puppetagent1.lab
sudo su -
puppet agent -t
```



If in Windows and the above command fails, try:

`powershell -command "vagrant up"` and `powershell -command "vagrant ssh puppetmaster"`


To destroy the lab

`vagrant destroy -f`