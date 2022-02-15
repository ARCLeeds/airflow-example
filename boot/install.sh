#!/bin/bash

apt update -y 
add-apt-repository ppa:deadsnakes/ppa
apt install -y git software-properties-common python3.9

apt upgrade -y docker
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose