# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

box = "centos/7"

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = box

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    vb.memory = "8192"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  config.vm.provision "shell", path: "./provision-script/common-setting.sh", :privileged => true

  config.vm.define "node1" do |node1|
    node1.vm.network "private_network", ip: "192.168.33.11", virtualbox__intnet: "intnet"
    node1.vm.provision "shell", inline: <<-SHELL
      hostname node1
      echo "node1" | sudo tee /etc/hostname > /dev/null
      # Hadoop
      wget http://ftp.riken.jp/net/apache/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz
      tar xf hadoop-2.8.2.tar.gz
      mkdir /home/vagrant/hadoop-2.8.2
      mount --bind ./hadoop-2.8.2 /home/vagrant/hadoop-2.8.2
      chmod 777 -R /home/vagrant/hadoop-2.8.2
    SHELL
    node1.vm.provision "shell", path: "./provision-script/hadoop-setup.sh", :privileged => true
  end

  config.vm.define "node2" do |node2|
    node2.vm.network "private_network", ip: "192.168.33.12", virtualbox__intnet: "intnet"
    node2.vm.provision "shell", inline: <<-SHELL
      hostname node2
      echo "node2" | sudo tee /etc/hostname > /dev/null
      # Hadoop
      wget http://ftp.riken.jp/net/apache/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz
      tar xf hadoop-2.8.2.tar.gz
      mkdir /home/vagrant/hadoop-2.8.2
      mount --bind ./hadoop-2.8.2 /home/vagrant/hadoop-2.8.2
      chmod 777 -R /home/vagrant/hadoop-2.8.2
    SHELL
    node2.vm.provision "shell", path: "./provision-script/hadoop-setup.sh", :privileged => true
  end

  config.vm.define "master" do |master|
    master.vm.network "forwarded_port", guest: 9000, host: 9000
    master.vm.network "private_network", ip: "192.168.33.10", virtualbox__intnet: "intnet"
    master.vm.provision "shell", inline: <<-SHELL
      hostname master
      echo "master" | tee /etc/hostname > /dev/null
      # Hadoop
      wget http://ftp.riken.jp/net/apache/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz
      tar xf hadoop-2.8.2.tar.gz
      mkdir /home/vagrant/hadoop-2.8.2
      mount --bind ./hadoop-2.8.2 /home/vagrant/hadoop-2.8.2
      chmod 777 -R /home/vagrant/hadoop-2.8.2
    SHELL
    #master.vm.provision "shell", run: "always", path: "./provision-script/setup-setting.sh", :privileged => true
    master.vm.provision "shell", path: "./provision-script/hadoop-setup.sh", :privileged => true
  end
end
