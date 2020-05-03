---
layout: post
title:  "Disable and enable user accounts in Linux"
date:   2019-11-21 15:38:000 +0100
tags: linux sysadmin user accounts
---

Sometimes you need to disable user accounts (say, people enter and leave the team). 

Other times, you need a fictional user just to run certain processes but that user is not a real person. This is useful for managing accesses and give the least possible amount of permissions.

These commands will lock users out of the machine in any kind of authentication (ssh-key, password-based logins, etc).


### Expire account

```bash
# disallow peter from logging in
sudo usermod --expiredate 1 user
```

### Re-enable account

```bash
# set expiration date of peter to Never
sudo usermod --expiredate "" peter
```

### Force user to re-enter a password 

This will expire the current password of the user, but allow them to log in after they enter a new one.

```bash
# make peter think of a new password on login
sudo passwd -e  YYYY-MM-DD peter
```

#### Source

[Credits](https://askubuntu.com/questions/282806/how-to-enable-or-disable-a-user).
