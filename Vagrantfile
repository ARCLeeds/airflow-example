Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.hostname = "airflow-box"
  config.vm.provision :docker
  config.vm.provision :docker_compose
  
  config.vm.network "forwarded_port", guest: 8080, host:8080

  config.vm.provision :shell, path:"boot/install.sh"
end

