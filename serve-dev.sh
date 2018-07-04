#!/usr/bin/env bash

#use latest ruby
rvm use 2.5.1

#serve blog
bundle exec jekyll serve --config _config-dev.yml
