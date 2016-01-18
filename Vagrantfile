Vagrant.configure("2") do |config|
  config.landrush.enabled = true
  config.vm.box = "vagrant-base"
  config.vm.box_url = "s3://patoarvizu-vagrant/vagrant-base.box"
  config.vm.define "chef" do |chef|
    chef.vm.provision "bootstrap", type: "shell", path: "chef-bootstrap.sh", privileged: false
    chef.vm.provision "update", type: "shell", path: "chef-zero-update.sh", privileged: false
    chef.vm.network "private_network", ip: "10.0.1.2"
    chef.vm.hostname = "chef.vagrant.dev"
  end

  config.vm.define "server" do |server|
    server.vm.network "private_network", ip: "10.0.1.3"
    server.vm.network "forwarded_port", guest: 80, host: 8080
    server.vm.hostname = "nagios-server.vagrant.dev"
    server.vm.provision "chef_client" do |chef|
      chef.version = "12.5.1"
      chef.chef_server_url = "http://chef.vagrant.dev:8889"
      chef.validation_key_path = "dummy.pem"
      chef.validation_client_name = "dummy" 
      chef.node_name = "nagios-server"
      chef.run_list = "role[nagios-server]"
      chef.environment = "dev"
      chef.delete_client = true
      chef.delete_node = true
    end
  end

  config.vm.define "client" do |client|
    client.vm.network "private_network", ip: "10.0.1.4"
    client.vm.hostname = "client.vagrant.dev"
    client.vm.provision "chef_client" do |chef|
      chef.version = "12.5.1"
      chef.chef_server_url = "http://chef.vagrant.dev:8889"
      chef.validation_key_path = "dummy.pem"
      chef.validation_client_name = "dummy" 
      chef.node_name = "nagios-client"
      chef.run_list = "role[nagios-client]"
      chef.environment = "dev"
      chef.delete_client = true
      chef.delete_node = true
    end
  end

  config.vm.define "kal_el" do |kal_el|
    kal_el.vm.network "private_network", ip: "10.0.1.5"
    kal_el.vm.hostname = "kal-el.vagrant.dev"
    kal_el.vm.provision "chef_client" do |chef|
      chef.version = "12.5.1"
      chef.chef_server_url = "http://chef.vagrant.dev:8889"
      chef.validation_key_path = "dummy.pem"
      chef.validation_client_name = "dummy"
      chef.node_name = "kal-el"
      chef.run_list = "role[nagios-solo-client]"
      chef.environment = "dev"
      chef.delete_client = true
      chef.delete_node = true
    end
  end
end
