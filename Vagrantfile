Vagrant.configure(2) do |config|
  config.vm.define "consul1" do |consul1|
    consul1.vm.box = "cbednarski/ubuntu-1404"
    consul1.vm.network "private_network", ip: "10.7.0.5"
    consul1.vm.provision "shell", inline: "hostnamectl set-hostname consul1"
    consul1.vm.provision "shell", inline: "cd /vagrant/ && make install"
  end

  config.vm.define "consul2" do |consul2|
    consul2.vm.box = "cbednarski/ubuntu-1404"
    consul2.vm.network "private_network", ip: "10.7.0.6"
    consul2.vm.provision "shell", inline: "hostnamectl set-hostname consul2"
    consul2.vm.provision "shell", inline: "cd /vagrant/ && make install"
  end

  config.vm.define "consul3" do |consul3|
    consul3.vm.box = "cbednarski/ubuntu-1404"
    consul3.vm.network "private_network", ip: "10.7.0.7"
    consul3.vm.provision "shell", inline: "hostnamectl set-hostname consul3"
    consul3.vm.provision "shell", inline: "cd /vagrant/ && make install"
  end
end
