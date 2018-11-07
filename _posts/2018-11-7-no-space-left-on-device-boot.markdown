---
layout: post
title:  "No space left on device - Full /boot partition"
date:   2018-11-05 15:17:00 +0200
categories: sysadmin boot no space left on device
---

Do you have messages like this?

```bash
update-initramfs: Generating /boot/initrd.img-4.4.0-119-generic
W: mdadm: /etc/mdadm/mdadm.conf defines no arrays.

gzip: stdout: No space left on device
E: mkinitramfs failure cpio 141 gzip 1
update-initramfs: failed for /boot/initrd.img-4.4.0-119-generic with 1.
```

Your `/boot` partition is full, but it has old linux kernels and the current one. `apt-get` is never able to clean up, because the `/boot` partition is full! How to clean this?

## Go to `/boot`

```bash
cd /boot
```

## See which kernel you are using

```bash
uname -r
```

## Clean up

```bash
dpkg --list | grep linux-image
```

```bash
# For every kernel that is not the one you are using, run:
sudo apt-get -f purge linux-image-extra-4.4.0-1*

# when you are finished, clean up everything
sudo apt autoremove

# update grub
sudo update-grub2
# reboot
sudo reboot
```

## If apt based solution does not work, pray and do this before the Clean Up step

### Delete old kernels besides this one

```bash
cd /boot
# **Modify the wildcarded versions according to your existing kernel!**
sudo rm -rf vmlinuz-4.4.0-1* System.map-4.4.0-1* abi-4.4.0-1* initrd-4.4.0-1* config-4.4.0-1*
```
