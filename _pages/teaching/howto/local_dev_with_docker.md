---
layout: page
title: Using Docker for local development (PHP)
include_in_menu: false
permalink: /howto/local_dev_with_docker
crumbtitle: Docker for Local Development
---

# IN CONSTRUCTION

##  Objective

Sometimes your FEUP server, gnomo.fe.up.pt, can misbehave or be misconfigured. If you encounter `Forbidden` errors or any other mysterious stuff, but want to get some work done, try [Docker](https://www.docker.com/products/docker-desktop) to set a Apache + PHP Container in your local machine (you need Admin rights!).

## Register for Docker Hub

*(For Windows users)*

Register [here](https://hub.docker.com/signup) for free. You need a set of credentials to download the Docker engine.

## Install Docker

For Windows and Mac, simply download the [Docker Desktop Installer](https://www.docker.com/products/docker-desktop) and run it. 

For Ubuntu Linux, I have compiled a script for easy installation.

1. Fire up the Terminal, 
2. Run `sudo -i` and type user password
3. `exit` the root command line
4. Paste the script found [here](/install/docker/ubuntu/18/2018/11/05/install-docker-ubuntu18/) in the Terminal.

## Fire up the container

1. Create a new folder somewhere
2. Open a Windows  (`cmd.exe`) / Linux / Mac Terminal and run this:
3. Navigate (`cd`) to the folder you created before
4. Run the following command:

(Linux)

```bash
docker run -d -p 8080:8080 -it --name=php -v $(pwd)/var/www/html:/var/www/html quay.io/vesica/php73:dev
```





