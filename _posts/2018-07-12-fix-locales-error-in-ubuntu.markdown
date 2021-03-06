---
layout: post
title:  "Fixing locales error in Ubuntu"
date:   2018-07-12 15:47:00 +0100
tags: sysadmin ubuntu locales fix
---

Tired of warning about locales in Ubuntu? Me too, and there is a fix.


## The problem

You login, you try to compile something, etc. All the time you see this:

```shell

perl: warning: Setting locale failed.   
perl: warning: Please check that your locale settings:   
        LANGUAGE = "en_US:en",   
        LC_ALL = (unset),   
        LC_MESSAGES = "en_US.UTF-8",   
        LANG = "en_US.UTF-8"   
    are supported and installed on your system.   

```


## The fix

Edit the file `/etc/environment` and add this:

```shell
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
```

If it still fails, add the same lines to `/etc/default/locale`.
