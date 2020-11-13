---
layout: post
title:  "Hackintosh: mapping USB ports correctly (for OpenCore)"
date:   2020-08-30 9:21:000 +0100
tags: macos mapping usb ports opencore
published: false
---

Do you have a hackintosh that wakes up immediately after sleeping? Most likely you have to map your usb ports correctly.



## Mapping USB Ports



## Sleep issues with Corsair AIO Water Coolers on Hackintosh

I discovered that Corsair AIO Coolers will trigger an immediate wake up from sleep whenever the Corsair Link USB controller is plugged into the USB header. 

Unplug the microusb cable from the pump-waterblock and see if the sleep issue goes away. It solved it for me. I have a Corsair H115i Pro AIO, for that matter.

