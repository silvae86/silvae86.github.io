---
layout: post
title:  "Fixing broken R packages in Ubuntu 16.04"
date:   2019-04-02 15:30:00 +0100
categories: ubuntu r-language apt-get sysadmin broken package
---

I had an issue with install R on Ubuntu 16.04. Message was about some inability to install a dependency of 

## Problem

```shell
r-base : Depends: r-recommended (= 3.5.1-1build1) but it is not going to be installed E: Unable to correct problems, you have held broken packages.
```

## Solution

I needed to fix some broken packages? What solved it for me:

```shell
sudo apt --fix-broken install
sudo apt autoremove
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install r-base-dev
```
