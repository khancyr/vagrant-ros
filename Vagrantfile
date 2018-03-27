# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
      # Don't boot with headless mode
      vb.gui = true
      #
      #   # Use VBoxManage to customize the VM. For example to change memory:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      # Make some effort to avoid clock skew
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "5000"]
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start"]
      vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore", "1"]
  end

  # If you are on windows then you must use a version of git >= 1.8.x
  # to update the submodules in order to build. Older versions of git
  # use absolute paths for submodules which confuses things.

  # removing this line causes "A box must be specified." error:
  config.vm.box = "ubuntu/xenial64"

  # LTS, EOL April 2021
  config.vm.define "xenial64", autostart: true do |xenial64|
    config.vm.box = "ubuntu/xenial64"
    config.vm.provision :shell, path: "initvagrant.sh"
  end

end

