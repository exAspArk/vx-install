# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'

  config.vm.provider "virtualbox" do |vb, override|
    override.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box'
  end

  config.vm.provider "vmware_fusion" do |fs, override|
    override.vm.box_url = 'http://files.vagrantup.com/precise64_vmware.box'
  end

  %w{ mq web worker logger }.each_with_index do |name, idx|
    config.vm.define name.to_sym do |s|
      ip = "192.168.47.#{idx + 10}"
      s.vm.network :private_network, ip: ip
      s.vm.hostname = "#{name}.vexor.local"

      case name
      when  "worker"
        s.vm.network :forwarded_port, guest: 4243, host: 4243 # docker
        s.vm.network :forwarded_port, guest: 2022, host: 2122 # docker
      when  "web"
        s.vm.network :forwarded_port, guest: 5432, host: 5432 # pg
      when "mq"
        s.vm.network :forwarded_port, guest: 5672, host: 5672 # amqp
        s.vm.network :forwarded_port, guest: 15672, host: 15672 # amqp ui
      end
    end
  end
end

