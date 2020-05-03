#!/usr/bin/env bash

rm -rf _site
bundle exec jekyll build
bundle exec htmlproofer ./_site --allow-hash-href
