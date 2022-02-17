Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.hostname = "airflow-box"
  config.vm.provision :docker
  config.vm.provision :docker_compose

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 2
  end
  
  config.vm.network "forwarded_port", guest: 8080, host:8080

  config.vm.synced_folder ".", "/home/vagrant/airflow", type: "rsync",
    rync__exclude: ".vagrant/"

  config.vm.provision :shell, path:"boot/install.sh"
end

