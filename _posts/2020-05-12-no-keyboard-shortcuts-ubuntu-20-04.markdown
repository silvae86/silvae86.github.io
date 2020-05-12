---
layout: post
title:  "Solving no keyboard shortcuts after upgrade to Ubuntu 20.04"
date:   2020-05-12 12:05:000 +0100
tags: ubuntu 20.04 upgrade keyboard fix
---

After upgrading to Ubuntu 20.04 I saw that my keyboard shortcuts no longer worked (`Ctrl + T,` `Shift Insert`, `Ctrl + V`...). The `Super` key also was not working.

### Issues in terminal

I also saw that while I was in the Terminal, pressing `Ctrl + U`, for example, would no longer delete the current command but instead just blink the cursor between white and black.

### Solution

The solution for this was to go into the Settings app, Regional settings, and remove all Keyboards except the only one I use (Portuguese).

![How to succeed in the practical work]({%- link /assets/images/post-images/2020-05-12-no-keyboard-shortcuts-ubuntu-20-04/settings.png -%}){:class="img-responsive"}

After that, I ran `sudo dpkg-reconfigure keyboard-configuration` and followed the steps.

For my Lenovo T420, I used the Lenovo T61 Keyboard type, as there was no specific option. However, since they both share the same 8-row keyboard, I figured it would work.
