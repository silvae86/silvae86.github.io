---
layout: post
title:  "Squid proxy cache in an ancient, hacked up Mac Mini 1.1"
date:   2019-01-10 0:46:00 +0100
tags: sysadmin squid file caching mac homebrew
---

A proxy cache server acts as an intermediary between your machine and the internet. Say, for example, you have two machines in your network, and a third machine that you want to dedicate to caching web content. Here is how to set it up on a Mac.

{% include warning.html content="Page in construction!" %}

## Example

Let us show a very simple example:

![Caching1](/assets/images/post-images/2019-01-10-setup_squid_in_mac_with_homebrew/caching1.png){:class="img-center"}
*Cache miss*{:class="img-caption"}

Machine 2 asks for a file from the proxy, but the proxy does not have it. It will be downloaded and put into the proxy cache. 

![Caching2](/assets/images/post-images/2019-01-10-setup_squid_in_mac_with_homebrew/caching2.png){:class="img-center"}
*Cache hit!*{:class="img-caption"}

Machine 1 asks for the same file again; this time, the file is served by the cache! No bandwidth is used apart from the local LAN traffic. The download is super fast too.

## How to set up a proxy cache in Mac OS X



## Interesting applications

Setting up a web cache proxy can dramatically increase your internet speed when you are:

- Performing large software installs where a lot of dependencies need to be downloaded
- Downloading very large Docker images on a network of computers who are constantly deploying the same images over and over again (software testing is an example). Docker has its own cache, but sometimes even Docker crashes and the Docker image needs to be reset, requring sometimes 60GB of downloads! 

## Background story

I had a very old Mac Mini from 2006 lying around the house that I bought around 7 or 8 years for 150€ second hand at the time. It was my personal web server for 5+ years since then, until I placed it in a drawer and forgot about it.

![Miniserver](/assets/images/post-images/2019-01-10-setup_squid_in_mac_with_homebrew/miniserver.jpg){:class=float-left"}
*My Mac Mini*{:class="img-caption"}

The original specs were:

- 1.5GHz Intel Core Solo 
- 2 x 256MB 667 Mhz DDR2 RAM
- 80 GB 4200rpm HDD

Since then, I hacked it up to this:

- 2.33Ghz Intel Core 2 Duo T7600 (from eBay, 10€ posted)
- 2 x 1024MB 667 Mhz DDR2 RAM (another 10€ from eBay)
- 256 GB SSD (second hand, 25€)
- EFI [Flashed to Mac Mini 2.1](http://forum.netkas.org/index.php?action=printpage;topic=874.0)
- OS X Mavericks (10.9), using the hacks provided by [OS X Hackers](https://osxhackers.net/mavericks.html). I had a little more support for more modern software, but don't have GPU acceleration a server seldom needs that kind of thing. 

It is still a snail, but it is very silent and still runs Mac OS X. Yes, I could run Linux on it, but it would defeat the purpose of owning a Mac, even if it is now hacked beyond redemption. I know it is not safe to use hacked Kernel Extensions, but hey, it was an interesting challenge to make this work.

It can still do some interesting things besides just serving. Since it is so sloooow I cannot even run YouTube on it, so I write more... Like this blog post, which was entirely written on it!!


