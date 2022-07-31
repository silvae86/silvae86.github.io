---
layout: post
title:  "Homebrew: A list of useful casks for NodeJS developers"
date: 2022-07-30 14:40:000 +0100
tags: macos homebrew casks development
published: true
comments_id: 51
---

All the casks I usually like to install on a new developer machine.


```bash
#!/usr/bin/env bash



/bin/bash -c "$(cat install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/joaorocha/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask rectangle
brew install --cask karabiner-elements
brew install --cask iterm2
brew install --cask alt-tab 
brew install --cask stats
brew install --cask webstorm
brew install --cask keka
brew install --cask chromium
brew install --cask firefox
brew install --cask signal
brew install --cask sqlpro-for-postgres
brew install --cask max
brew install --cask libreoffice
brew install --cask textmate
brew install --cask forklift
brew install --cask copyclip
brew install --cask sensiblesidebuttons
brew install --cask htop
brew install --cask wget
brew install --cask curl

# nvm
brew install nvm

# Docker
brew install docker
brew install docker-compose
mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
```