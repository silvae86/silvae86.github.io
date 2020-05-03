#!/usr/bin/env bash

# Build to check for broken links
bundle exec jekyll build --config _config.yml
bundle exec htmlproofer ./_site
