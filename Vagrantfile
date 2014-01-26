# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'

  config.vm.provider "virtualbox" do |vb|
    vb.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box'
  end

  config.vm.provider "vmware_fusion" do |fs, override|
    override.vm.box_url = 'http://files.vagrantup.com/precise64_vmware.box'
  end

  %w{ mq web worker }.each_with_index do |name, idx|
    config.vm.define name.to_sym do |s|
      ip = "192.168.47.#{idx + 10}"
      s.vm.network :private_network, ip: ip
      s.vm.hostname = "#{name}.vexor.local"
    end
  end
end

