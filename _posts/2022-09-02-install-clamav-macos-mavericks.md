---
layout: post
title:  "Installing clamav (open-source antivirus) for Mac using macports"
date: 2022-09-01 23:20:000 +0100
tags: osx macports antivirus vintage retro
published: true
comments_id: 52
---

Using a vintage Mac requires hardening, such as enabling the Firewall's Stealth Mode, disabling File Sharing options in the System settings, and installing an anti-virus and being overall mindful of which parts of the web you visit. Here is how to install clamav, a free and open-source alternative for older Apple hardware still stuck on older OS's. We will be using [MacPorts](https://www.macports.org/) for this short tutorial.

1. After installing macports, install the following 2 packages [^macports-clamav]:

	```shell
	sudo port install clamav
	sudo port install clamav-server
	```

2. By default, the `freshclam.conf` file comes empty [^cant-parse-clamav-settings]. Let's fix it. Edit the freshclam (process that regularly updates the virus definitions database)

	```shell
	sudo vim /opt/local/etc/freshclam.conf
	```
	
	Add this if the file does not have the `DatabaseMirror` line [^freshclam-fails]:
	
	```conf
	DatabaseMirror database.clamav.net
	```

3. Update antivirus definitions database
	```shell
	sudo freshclam
	```
	It will download a lot of data (> 250MB). Please wait until it finishes.

4. Enable clamav daemons for continuous database upgrades and background virus scanning
	```shell
	sudo port load clamav-server
	```

That being said, I do not recommend using a completely outdated and insecure OS as your main machine on a day-to-day basis. If my 2008 MacBook Pro were my only machine I would be running an up-to-date Linux distro. 

[^macports-clamav]: "Installing clamav/clamav-server is very annoying on MacPorts" [Link](https://trac.macports.org/ticket/50570)

[^cant-parse-clamav-settings]: "ERROR: Can’t open or parse the config freshclam.conf" [Link](http://linuxhostingsupport.net/blog/error-cant-open-or-parse-the-config-freshclam-conf)

[^freshclam-fails]: "sudo freshclam -d fails" [Link](https://github.com/Cisco-Talos/clamav/issues/333)


