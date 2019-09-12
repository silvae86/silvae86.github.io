#!/usr/bin/env bash

#use latest ruby
rvm use 2.5.1

#install bundle
bundle install

#serve blog
# bundle exec jekyll serve --config _config.yml --plugins _plugins
jekyll serve b -w --trace --config _config.yml
