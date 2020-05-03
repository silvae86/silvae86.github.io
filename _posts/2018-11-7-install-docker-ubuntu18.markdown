---
layout: post
title:  "Install Docker on Ubuntu 18"
date:   2018-11-05 16:54:00 +0200
tags: install docker ubuntu 18
redirect_from:
  - /install/docker/ubuntu/18/2018/11/05/install-docker-ubuntu18/
---

## Installation Script

Here is the "just copy and paste" installations script for Docker in Ubuntu. Enjoy.

```bash

# Install dependencies
sudo apt-get update -qq
sudo apt-get install -qq -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

# Install Docker
sudo apt-get install -y -qq docker-ce

# Start Docker Daemon
sudo service docker start

# Add yourself to the Docker user group, otherwise docker will complain that
# it does not know if the Docker Daemon is running
sudo usermod -aG docker ${USER}

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
source ~/.bashrc
docker-compose --version
echo "Done!"
```

## Checking if the service is running

```bash
sudo service docker status
```
