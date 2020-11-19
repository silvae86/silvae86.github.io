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

Several instruction guides are here to help you install Docker on any platform.


### Windows

Download the [Docker Desktop Installer](https://www.docker.com/products/docker-desktop) and run it.

#### Solutions to possible problems

Some possible errors have been listed here to point you towards a possible solution. **Not everyone will encounter these errors**.

- **Lack of virtualization support**

![Virtualization](/teaching/howto/local_dev_with_docker/screenshots/win/virtualization.png)

Remember to turn on Virtualization Support (or VT-x) on your computer's BIOS/ UEFI (press Delete/F2 before Windows Starts) in order to run virtualization apps like Docker or a VM Hypervisor. See more [here](https://docs.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/sect-Virtualization-Troubleshooting-Enabling_Intel_VT_and_AMD_V_virtualization_hardware_extensions_in_BIOS.html).

- **WSL2 Linux Kernel message**

If you get this when installing Docker, click the link in blue, follow the necessary instructions and then press the 'Restart' button.

![Wsl2](/teaching/howto/local_dev_with_docker/screenshots/win/wsl2.png)

- **Windows Firewall warnings**

When Docker first starts on Windows, you may get this prompt. Select 'Allow Access'.

![Firewall](/teaching/howto/local_dev_with_docker/screenshots/win/firewall.png)

### macOS

Simply download the [Docker Desktop Installer](https://www.docker.com/products/docker-desktop) and run it.

### Ubuntu Linux

I have compiled a script for easy installation.

1. Fire up the Terminal,
2. Run `sudo -i` and type user password
3. `exit` the root command line
4. Paste the script found [here](/2018/11/05/install-docker-ubuntu18/) in the Terminal.

## Start the container!

### Windows

#### Automated guide

1. Download [this zip file](/teaching/howto/local_dev_with_docker/docker-scripts-for-windows.zip).
2. Unzip the file into a folder of your choice.
3. You will see a folder called `docker-scripts-for-windows` after unzipping the file.
4. Inside `docker-scripts-for-windows`, you will see a folder called `html`, and 4 files:
	- 2 PowerShell Scripts (`.ps1` extension) &larr; **DO NOT TOUCH THESE**
	- 2 Windows Batch Files (`.bat` extension) &larr; **We will use these to start and stop our container**

5. To start the container, run the `start-container.bat` file.
6. Test your container, by navigating your browser to `http://localhost:8080`. You should see this:
	- ![Hello world page]({% link _pages/teaching/howto/local_dev_with_docker/screenshots/win/hello-world.png %})

7. To stop the container, run the `stop-container.bat` file.

#### Manual guide

1. Create a new folder `html` at the root of your hard drive for your website files: `C:\html`
2. Open a terminal (`cmd.exe`) **with administrator privileges** and run:

		```cmd
		docker run -d -p 8080:8080 -it --name=php -v C:\html:/var/www/html quay.io/vesica/php73:dev
		```

##### (Optional) Create a `.htaccess` file inside the `html` folder

This is optional, but will allow the web server to generate nice file listings for easy navigation. To turn this on, go to the Server Root and create a new file called `.htaccess`, including the dot. The contents of the folder should be this:

```apacheconf
Options +Indexes
```

After saving the file, point your browser to [http://localhost:8080](http://localhost:8080). You should see this:

![Indexes Enabled]({% link _pages/teaching/howto/local_dev_with_docker/screenshots/win/indexes.png %})

### Linux / Mac

1. Create a new `html` folder for your web files: `mkdir -p ~/html` (~ means your home folder)
2. Open a terminal and run:
	```bash
	docker run -d -p 8080:8080 -it --name=php -v ~/html:/var/www/html quay.io/vesica/php73:dev
	```
4. (Optional) [Create the .htaccess file](#optional-create-a-htaccess-file-inside-the-html-folder) inside the `~/html` folder.
3. Point your browser to [http://localhost:8080](http://localhost:8080).

## Place your files in the directory and start developing!

From now on, whatever you put in the `html` Folder, should be accessible in the browser via the link [http://localhost:8080](http://localhost:8080).
