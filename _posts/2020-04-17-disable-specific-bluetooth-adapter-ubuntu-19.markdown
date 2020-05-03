---
layout: post
title:  "Disabling a specific Bluetooth adapter in Ubuntu 19.10 (Hacked Lenovo T420)"
date:   2020-04-17 11:09:000 +0100
tags: ubuntu bluetooth configuration 19.10
redirect_from:
  - /sysadmin/squid/file/caching/mac/homebrew/2019/01/09/setup_squid_in_mac_with_homebrew/
---

This all started because my Bluetooth mouse was lagging and the pointer skipping!

Say you have a crappy built-in BT adapter, with a very old BT version (2.0, for example), and you pop in a new wifi card with combined Wifi-6 and BT 4.0 LE, such as the [AzureWave AW-CB160](https://www.ebay.co.uk/itm/BroadCom-AW-CB160-BCM94360HMB-WIFI-HALF-PCI-E-Wireless-BT-Card-BT4-0-WLAN-W003-/303426968043) with the BroadCom BCM94360HMB chipset. Wi-Fi ac at 1300Mbps was working out of the box, but Bluetooth 4.0 was nowhere to be found.

![Opening up the T420 to change the Wifi Card](/assets/images/post-images/2020-04-17-disable-specific-bluetooth-adapter-ubuntu-19/Screenshot from 2020-04-18 11:50:04.png){:class="img-responsive"}
*Opening up the T420 to change anything is a breeze. Right to repair FTW!*{:class="img-caption"}

Ubuntu Linux will automatically use the first adapter it detects, so your shiny new adapter will be ignored, and the system keeps using the other, older and weaker one.

### Approach?

I figured out that I needed reliable way to permanently disable a specific adapter (on boot!) in Ubuntu Linux when you have more than one. Many solutions online will tell you to use `/etc/rc.local`, [to add udev rules](https://askubuntu.com/questions/594843/how-can-a-specify-specific-bluetooth-adapter), or to [mess around](https://www.raspberrypi.org/forums/viewtopic.php?t=86963) with `bluetoothd`'s `main.conf`. I also tried adding hciconfig down commands to [/etc/rc.local](https://vpsfix.com/community/server-administration/no-etc-rc-local-file-on-ubuntu-18-04-heres-what-to-do/)... nothing worked for me.

Oh, and [blacklisting](https://askubuntu.com/questions/317004/how-to-completely-deactivate-a-bluetooth-usb-device) the driver only works if you have different manufacturers in your adapters. If they are both BroadCom, like my case... when you blacklist the driver, both adapters are disabled. Not good.


### Install the Broadcom firmware drivers

Go to Software -> Additional drivers and activate the Broadcom STA drivers ([some](https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers) say that they are junk, but hey, they work for me!)

![Activate Broadcom drivers](/assets/images/post-images/2020-04-17-disable-specific-bluetooth-adapter-ubuntu-19/Screenshot from 2020-04-17 11:26:30.png){:class="img-responsive"}

### Listing all active bluetooth adapters

Check it out. Run:

```shell
hciconfig -a
```

You will see something like this:

```bash

hci0:	Type: Primary  Bus: USB
	BD Address: XXXXXXXXXXXX  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING PSCAN ISCAN
  #
  # (more stuff)
  HCI Version: 2.0 # <---- the supported version of bluetooth

hci1:	Type: Primary  Bus: USB
  	BD Address: XXXXXXXXXXXX  ACL MTU: 1021:8  SCO MTU: 64:1
  	UP RUNNING PSCAN ISCAN
    #
    # (more stuff)
    HCI Version: 4.0 # <---- the supported version of bluetooth
```

As you will see, you have two adapters, one using Bluetooth 2.0 and one using 4.0 LE or up. We need to disable the older one.

### Disabling the specific adapter

After a lot of googling, here is what finally worked for me ([credits](https://ubuntuforums.org/showthread.php?t=1381674&page=2)):

1. Create a file in `/etc/init.d/disable_builtin_bluetooth`
  - `sudo vim /etc/init.d/disable_builtin_bluetooth`
2. Paste this
  ```shell
#!/bin/bash
echo "Disabling hci0 bluetooth adapter"
/usr/sbin/hciconfig hci0 down &
```
3. Give it execution permissions
```shell
sudo chmod +x /etc/init.d/disable_builtin_bluetooth
```
4. Run update-rc.d to wire all the symlinks needed for boot
```shell
update-rc.d nobluetooth start 26 2 3 4 5  .
```
5. Reboot
6. Run
```shell
hciconfig -a
```
You should see only one adapter now, with Bluetooth version 4.0:

```shell
hciconfig -a

hci0:	Type: Primary  Bus: USB # <-- It will now be hci0
  	BD Address: XXXXXXXXXXXX  ACL MTU: 1021:8  SCO MTU: 64:1
  	UP RUNNING PSCAN ISCAN
    #
    # (more stuff)
    HCI Version: 4.0 # <---- the supported version of bluetooth
```


## Why is this important to me?

I had to get it running on my ancient but much loved Lenovo T420. Check out the [specs](/2019/02/10/my-hacked-lenovo-t420/) of this Frankenstein of a laptop that I built over the years with some fancy goodies.
