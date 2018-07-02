---
layout: post
title:  "How to install Jekyll using Homebrew, Mac OSX 10.14 Mojave Beta"
date:   2018-07-02 16:36:07 +0100
categories: jekyll install mac osx sysadmin mojave
---

## Install XCode and components

Before starting this:

Install XCode, open it and install all components it asks you to

## Install homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Add binaries to path if you want
echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc

## Install ruby
brew install ruby

### (Optional) Fix homebrew links if necessary

sudo mkdir -p /usr/local/include
sudo mkdir -p /usr/local/lib
sudo chown -R $(whoami):admin /usr/local/include
sudo chown -R $(whoami):admin /usr/local/lib
brew list -1 | while read line; do brew unlink $line; brew link $line; done

## Install RVM and stable ruby
\curl -sSL https://get.rvm.io | bash -s stable --ruby

## Install Jekyll
sudo gem install jekyll

## Check Jekyll is working
jekyll -v


