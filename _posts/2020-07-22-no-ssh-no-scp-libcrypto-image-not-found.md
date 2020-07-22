---
layout: post
title:  "SSH and SCP broken: "
date:   2020-07-22 12:02:000 +0100
tags: libcrypto macos openssh homebrew error fix
---

Nagging error that happens again and again when I try to use `ssh` or `scp` in macOS (since Catalina):

```shell
scp . joaorocha@imacpro.local:/Users/joaorocha/Desktop
dyld: Library not loaded: /usr/local/opt/openssl@1.1/lib/libcrypto.1.1.dylib
  Referenced from: /usr/local/bin/scp
  Reason: image not found
[1]    33517 abort      scp . joaorocha@imacpro.local:/Users/joaorocha/Desktop
```

Solution that finally worked for me (Terminal commands):

```shell
brew update && brew upgrade
brew uninstall openssl
brew install https://github.com/tebelorg/Tump/releases/download/v1.0.0/openssl.rb
```
