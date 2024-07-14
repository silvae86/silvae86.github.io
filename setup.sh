#!/usr/bin/env bash

docker compose &>/dev/null # sending output to /dev/null because we don't want it printed

if [ $? -eq 0 ]; then
    echo "Docker compose is INSTALLED"
else
    echo "DOCKER NOT INSTALLED"
    exit 1
fi

docker compose build

# Copy Gemfile.lock from container to dir using dummy container
docker create --name dummy-silvae86-blog-container silvae86githubio-jekyll-silvae86-blog:latest
docker cp dummy-silvae86-blog-container:/setup_blog/Gemfile.lock ./Gemfile.lock
docker rm -f dummy-silvae86-blog-container