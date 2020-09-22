---
layout: page
title: Using Docker for local development (PHP)
include_in_menu: false
permalink: /teaching/howto/local_dev_with_docker
crumbtitle: Docker for Local Development
---

##  Objective

Sometimes your FEUP server, gnomo.fe.up.pt, can misbehave or your area in particular be misconfigured (some students have been encountering such issues this year).

If you encounter `Forbidden` errors or any other mysterious stuff, but want to get some work done, try [Docker](https://www.docker.com/products/docker-desktop) to set a Apache + PHP Container in your local machine (you need Admin rights!).

## Register for Docker Hub

*(For Windows users)*

Register [here](https://hub.docker.com/signup) for free. You need a set of credentials to download the Docker engine.

## Install Docker

For Windows and Mac, simply download the [Docker Desktop Installer](https://www.docker.com/products/docker-desktop) and run it.

For Ubuntu Linux, I have compiled a script for easy installation.

1. Fire up the Terminal,
2. Run `sudo -i` and type user password
3. `exit` the root command line
4. Paste the script found [here](/2018/11/05/install-docker-ubuntu18/) in the Terminal.

## Fire up the container

1. Create a new folder somewhere, for example ~/php in Linux (it will create a `php` folder in your home directory), or in Windows create the `C:\php`.
2. Open a Windows  (`cmd.exe`) / Linux / Mac Terminal and run this:
3. Navigate (`cd`) to the folder you created before
4. Run the following commands

(For Linux / Mac):

```bash
docker run -d -p 8080:8080 -it --name=php -v $(pwd)/html/site:/var/www/html quay.io/vesica/php73:dev
```

(For Windows):

```cmd
docker run -d -p 8080:8080 -it --name=php -v C:\webdev\html:/var/www/html quay.io/vesica/php73:dev
```

In Windows you may need to run cmd.exe as an administrator, because it needs that to be able to write to the `C:\webdev` folder. In Windows, accessing the hard drive root requires admin rights.

### The Server Root folder

From now on, we will call the folder `<folder that you created>/html` **Server Root**. This folder will will be where you will put your `php`, `html` and other files of your website.

## Create a `.htaccess` file in the Server Root

This is optional, but will allow the web server to generate nice file listings for easy navigation, like below:

![Indexes Enabled]({% link _pages/teaching/howto/local_dev_with_docker/indexes.png %})

To turn this on, go to the Server Root and create a new file called `.htaccess`, including the dot.

The contents of the folder should be this:

```apacheconf
Options +Indexes
```

## Place your files in the directory

From now on, whatever you put in the Root Folder, should be accessible in the browser via the link [http://localhost:8080](http://localhost:8080).

You should also get lists of folders and files directly in the browser, because you created the `.htaccess` file.
