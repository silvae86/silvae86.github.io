---
layout: post
title:  "Tuning the sensitivity of the Lenovo TrackPoint on Ubuntu"
date:   2019-05-17 01:28:000 +0100
tags: TrackPoint Ubuntu Sensitivity Tuning
redirect_from:
  - "/trackpoint/ubuntu/sensitivity/tuning/2019/05/17/tuning-ibm-lenovo-trackpoint/"
---

I have recently installed Ubuntu Budgie on my Lenovo ThinkPad T420. So far, the experience has been great. However, a crucial part of the IBM/Lenovo experience is the TrackPoint, the red nub at the center of the keyboard. Love it or hate it, for many people it is the main reason to buy a ThinkPad. Here is how I configure it to run on Ubuntu. This was tested with Ubuntu 18.04 LTS.

## Setting up persistent sensitivity settings for the TrackPoint

1. First, install `sysfsutils`:

```bash
sudo apt-get install sysfsutils
```

2. Second, edit the `/etc/sysfs.conf`. Add the following lines at the end.

```conf
#tweak trackpoint
devices/platform/i8042/serio1/serio2/sensitivity = 215
devices/platform/i8042/serio1/serio2/rate = 280
devices/platform/i8042/serio1/serio2/speed = 150
devices/platform/i8042/serio1/serio2/inertia = 1
```

These are my personal settings so far. Play with the values until you find the ones that suit your usage.

3. Try out different configurations

Adjust the values and run `sudo service sysfsutils restart` to try out the new values until you get it just right for yourself.
