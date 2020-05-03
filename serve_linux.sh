#!/usr/bin/env bash

#/bin/bash --login

source ~/.rvm/scripts/rvm
source ~/.bashrc

#use latest ruby
rvm use 2.5.1

#install bundle
bundle install

echo "Cleaning site."
rm -rf _site

echo "Building site."
# Build to check for broken links
bundle exec jekyll build --config _config.yml

#serve site
bundle exec jekyll serve --config _config.yml --plugins _plugins --safe --skip-initial-build &
SERVER_PID=$!

bundle exec htmlproofer \
  --url-ignore "/#.*/" \
  --internal-domains localhost:4000 \
  --assume-extension \
  --disable_external \
  ./_site

function kill_server {
    echo "Killing Server (PID $SERVER_PID) ...";
    kill -9 "$SERVER_PID"
}

trap kill_server INT
