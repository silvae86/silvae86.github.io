#!/usr/bin/env bash

rm -rf _site
bundle exec jekyll build
bundle exec htmlproofer \
  --url-ignore "/#.*/" \
  --internal-domains localhost:4000 \
  --assume-extension \
  --disable_external \
  ./_site
