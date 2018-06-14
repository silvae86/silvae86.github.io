#!/usr/bin/env bash

#install nvm
\curl -sSL https://get.rvm.io | bash

#activate rvm
source ~/.rvm/scripts/rvm

#install latest ruby
rvm install 2.5.1

#use latest ruby
rvm use 2.5.1

#set default ruby
rvm default 2.5.1

#install jekyll and bundle
gem install jekyll bundle

#install deps
bundle install

#serve blog
bundle exec jekyll serve
