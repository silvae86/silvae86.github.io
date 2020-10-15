---
layout: post
title:  "Restoring a dmg file to USB using only the Terminal"
date:   2020-10-15 20:11:000 +0100
tags: macos junk legacy dmg boot restore image snow leopard mountain lion
---

If you need to restore an image of an old version of Mac OS X (Leopard or Snow Leopard, for example), using a newer version of macOS (Mojave or Catalina) you may encounter messages like this, due to the uselessness of the newer versions of Disk Utility. 

```
Could not find any scan information. The source image needs to be imagescanned before it can be restored.
```

It seems Apple keeps removing features from these previously good utilities to make us throw away our Macs just because we cannot restore a simple image!! 

One day they will remove the Terminal too, and on that day I will be forced to use Linux as a desktop OS (gasp!). But not this day!

### Format your USB drive

![Formatting USB Drive for restore using macOS Disk Utility](/assets/images/post-images/2020-10-15-restore-mac-dmg-only-using-terminal/disk-restore.png){:class="img-center"}


### Use `asr` to restore a `.dmg` file

Let's ditch the Disk Utility for restoring and use Terminal.

Open up Terminal and type this:

```bash
sudo /usr/sbin/asr restore 
--source '/Users/joaorocha/Mac OS X Install DVD Snow Leopard RETAIL 10.6.3.dmg'  # source image
--target '/Volumes/UNTITLED 2' # target USB drive volume (as mounted in Finder)
--erase
-noverify # avoids 'Could not find any scan information. The source image needs to be imagescanned before it can be restored.' error by skipping image verification! Use at your own peril and calculate md5 of the image before
```


