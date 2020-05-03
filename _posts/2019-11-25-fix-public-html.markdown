---
layout: post
title:  "Fixing permissions of the public_html folder"
date:   2019-11-25 14:20:000 +0100
tags: linux sysadmin gnomo feup public html
---

Sometimes you may not be able to run PHP files or view HTML in a web server. This can be 
related to permissions and/or the lack of a `.htaccess` file in your `public_html` folder.

### Do you have a `public_html` folder?

```bash
ssh upXXXXXXXX@gnomo.fe.up.pt
ls -la 
```

Do you see a `public_html` folder? If it does not exist, run the following command:

```bash
mkdir public_html
```

### Make sure that your public_html folder contains a .htaccess file with the right contents

```bash
cd public_html
vim .htaccess
```

paste the following contents: 

```bash
Options +Indexes
```

To save and exit, press `:wq`

### Fix permissions on `public_html`

```bash
cd ..
chmod -R 0755 public_html
```

### Bonus: 

[Guide](https://www.up.pt/it/en/services/networks-and-connectivity/vpn-eca13b99) on how to configure the VPN in FEUP.

