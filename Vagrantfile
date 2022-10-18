MASTER_IP       = "172.16.8.252"
NODE_IP_SUBNET  = "172.16.8"

NUM_AGENTS = ENV['PUPPET_NUM_AGENTS'] || 2
NUM_AGENTS = Integer(NUM_AGENTS)
MASTER_CPU = 1
MASTER_MEM = 1024
AGENT_CPU = 1
AGENT_MEM = 1024

CONTROL_REPO='https://github.com/trungdtbk/puppet-exercise.git'

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #https://www.dissmeyer.com/2020/02/11/issue-with-centos-7-vagrant-boxes-on-windows-10/
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  boxes = Array.new
  boxes.push({ :name => "puppetmaster.lab", :ip => MASTER_IP, :cpus => MASTER_CPU, :memory => MASTER_MEM })

  for i in 1..NUM_AGENTS do 
    boxes.push({ :name => "puppetagent#{i}.lab", :ip => "#{NODE_IP_SUBNET}.#{i+100}", :cpus => AGENT_CPU, :memory => AGENT_MEM })
  end

  boxes.each do |opts|
    config.vm.define opts[:name] do |box|
      box.vm.hostname = opts[:name]
      box.vm.network :private_network, ip: opts[:ip]
 
      box.vm.provider "virtualbox" do |vb|
        vb.cpus = opts[:cpus]
        vb.memory = opts[:memory]
        vb.name = opts[:name]
      end
      if box.vm.hostname == "puppetmaster.lab" then 
        box.vm.provision "shell", path:"./install-puppet-master.sh", args: "#{CONTROL_REPO}"
      else
        box.vm.provision "shell", path:"./install-puppet-agent.sh"
      end

    end
  end
end