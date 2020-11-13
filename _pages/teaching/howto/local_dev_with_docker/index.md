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

## Install Docker

For Windows and Mac, simply download the [Docker Desktop Installer](https://www.docker.com/products/docker-desktop) and run it.

For Ubuntu Linux, I have compiled a script for easy installation.

1. Fire up the Terminal,
2. Run `sudo -i` and type user password
3. `exit` the root command line
4. Paste the script found [here](/2018/11/05/install-docker-ubuntu18/) in the Terminal.

## Fire up the container

- **Windows**
    1. Create a new folder for your web files: `C:\php`
    2. Open a terminal (`cmd.exe`) **with administrator privileges** and run:
        ```cmd
        docker run -d -p 8080:8080 -it --name=php -v C:\php\html:/var/www/html quay.io/vesica/php73:dev
        ```

- **Linux / Mac**
    1. Create a new folder for your web files: `~/php`
    2. Open a terminal and run:
        ```bash
        docker run -d -p 8080:8080 -it --name=php -v ~/php/html:/var/www/html quay.io/vesica/php73:dev
        ```

### The Server Root folder

From now on, we will call the folder `php/html` **Server Root**. This folder will be where you will put your `php`, `html` and other files of your website.

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
