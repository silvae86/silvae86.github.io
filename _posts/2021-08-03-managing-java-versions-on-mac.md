---
layout: post
title:  "Java versions on macOS without pain, complete guide"
date: 2021-08-02 20:00:000 +0100
tags: java macos versions jenv homebrew adoptopenjdk
comments_id: 43
---

An ages-long problem that once in a while comes to take a couple of hours away from a developer: How to properly manage multiple versions of Java in a single Mac, and how to switch between them *painlessly*.

Perhaps more importantly, other applications such as Maven should be aware of the version of Java that is active and use that one. This can be achieved by dynamically setting up the `JAVA_HOME` environment variable.

In this guide we will configure our environment using [Homebrew](https://brew.sh), [AdoptJDK 1.8](https://github.com/AdoptOpenJDK/homebrew-openjdk), [jenv](https://www.jenv.be), and set up our [zsh](https://ohmyz.sh) to automatically load the appropriate java version and set `JAVA_HOME` for us whenever we start up the terminal. This is what makes [Maven](https://maven.apache.org) and other tools use our default Java version until we change it using [jenv](https://www.jenv.be).

Tested on macOS Big Sur, but should work in other versions.

## Install Homebrew

Basically `apt-get` / `rpm` / `yum` / `apk` / `<yet another Linux package manager that we need to learn because reasons>`, but for Mac. And because Mac only has one distro, you only need to learn one package manager! /s.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

It works. Use it.

## Install AdoptJDK

```shell
brew tap AdoptOpenJDK/openjdk
brew install --cask adoptopenjdk8
```

## Install jenv

It is like `nvm` for Java. Thank the Gods for this.

```bash
brew install jenv
````

### Add your AdoptJDK installation to jenv

```bash
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
```

### Set the global Java version using jenv

```bash
jenv global 1.8
```

## Set up .zshrc

Now we need to edit `~/.zshrc` to automatically load and change the set `JAVA_HOME` for us on startup. 

```shell
vim ~/.zshrc
```

Add at the end of the file (Shift + g) &rarr; a &rarr; Cmd+V &rarr; Esc &rarr; :wq &rarr; Enter

```shell
# set up jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
 
# Magic lines, credits https://github.com/jenv/jenv/issues/44
export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'
 
# call function on boot to set the JAVA_HOME var on every terminal startup
jenv_set_java_home
```

## Test it out

Open a new Terminal and run this line.

```bash
java -version
```

It should print out version 1.8, which is the one we installed.



