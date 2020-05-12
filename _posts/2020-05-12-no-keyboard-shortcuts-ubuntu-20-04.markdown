---
layout: post
title:  "Solving no keyboard shortcuts after upgrade to Ubuntu 20.04"
date:   2020-05-12 12:05:000 +0100
tags: ubuntu 20.04 upgrade keyboard fix
---

After upgrading to Ubuntu 20.04 I saw that my keyboard shortcuts no longer worked (`Ctrl + T,` `Shift Insert`, `Ctrl + V`...). The `Super` key also was not working.

## Issues in terminal

I also saw that while I was in the Terminal, pressing `Ctrl + U`, for example, would no longer delete the current command but instead just blink the cursor between white and black.

## Possible solution 1 - Disable Locate Pointer

Go to your Settings app and make sure that the "Locate Pointer" option is disabled:

![Disabling Locate Pointer in Accessibility]({%- link /assets/images/post-images/2020-05-12-no-keyboard-shortcuts-ubuntu-20-04/disable-locate-pointer.png -%}){:class="img-responsive"}

## Possible solution 2 - Remove all languages in Regional Settings except one

The solution for this was to go into the Settings app, Regional settings, and remove all Keyboards except the only one I use (Portuguese).

![Ubuntu Regional Settings]({%- link /assets/images/post-images/2020-05-12-no-keyboard-shortcuts-ubuntu-20-04/settings.png -%}){:class="img-responsive"}

After that, I ran `sudo dpkg-reconfigure keyboard-configuration` and followed the steps.

For my Lenovo T420, I used the Lenovo T61 Keyboard type, as there was no specific option. However, since they both share the same 8-row keyboard, I figured it would work.

I chose right alt to be the AltGr and disabled the special input key (typically allows you to input characters by pressing Ctrl + ASCII code). I want the least interference with my Ctrl keys as possible!

## Possible solution 3 - Select IBus as your input method system

Open Terminal

```shell
gnome-language-settings
```

Select IBus in the combo box below.

![Select IBus as input method system]({%- link /assets/images/post-images/2020-05-12-no-keyboard-shortcuts-ubuntu-20-04/ibus.png -%}){:class="img-responsive"}

## Possible solution 4 - Fix bugs with shortcuts in Xorg

I was editing text and felt that __sometimes__ the `Ctrl` key would fail on the first times I used `Ctrl + Shift + Left` or `Ctrl + Shift + Right` to select text. Seems like this is a [very old bug in Xorg](https://bugs.launchpad.net/xorg-server/+bug/36812), where `Ctrl + Shift` is captured by the system as a shortcut to change keyboard layout, instead of being considered a text selection operation.

User [Norbert](https://launchpad.net/~nrbrtx) has already published a PPA to deal with this [here](https://launchpad.net/~nrbrtx/+archive/ubuntu/xorg-hotkeys). If you have this behaviour, run these commands:

```shell
sudo add-apt-repository ppa:nrbrtx/xorg-hotkeys
sudo apt-get update
sudo apt-get dist-upgrade
```

This seems to be supported on everything except GNOME, so I leave another alternative below...
