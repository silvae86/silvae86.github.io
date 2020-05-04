---
layout: post
title:  "How to set up MAMP to enable .htaccess and mod_rewrite debugging"
date:   2019-01-01 0:10:06 +0100
tags: sysadmin apache mamp mod_rewrite
redirect_from:
  - "/sysadmin/apache/mamp/mod_rewrite/2018/12/31/setup_mod_rewrite_and_htaccess_in_mamp/"
---

Here is how to enable htaccess overrides in a [MAMP](https://www.mamp.info/en/) server for local development. This is useful to test PHP configurations where you want to use a `.htaccess` file to redirect all requests to a specific file, say, an `index.php` that acts as a router, enabling you to use pretty URIs such as `/users`, `/users/new`, etc. for your PHP application.

## Enable .htaccess overrides in the entire server

Before:

```
<Directory />
    Options Indexes FollowSymLinks
    AllowOverride None
</Directory>
```

After:

```
<Directory />
    Options Indexes FollowSymLinks
    AllowOverride All
</Directory>
```


## Enable mod_rewrite log for debugging


```
# Mod rewrite configs

RewriteEngine On
RewriteLog "/Applications/MAMP/logs/rewrite.log"
RewriteLogLevel 5
```

Then you can `tail -f /Applications/MAMP/logs/rewrite.log` to debug your rewrites.


{% include danger.html content="These configurations are a serious security hole and therefore are for development ONLY!" %}
