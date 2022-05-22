---
layout: post
title:  "Dockerizing NodeJS development for Apple Silicon and Intel"
date: 2022-04-22 16:34:000 +0100
tags: docker linux macintosh pyenv apple silicon monterey docker devops docker-compose development
published: false
---

More and more developers are looking into Apple Silicon Macs as their new work machines. Based on the innovations brought about by the Apple processors found on the iPhone, Apple Silicon delivers unprecedented performance per watt. This means no noise on 99% of daily operations, while delivering much greater performance than their previous Intel x86 counterparts. 

Like many developers, I used 16'' MacBook Pros with Intel Core i7 processors since they were out, and I know that such machines run toasty hot all the time... at least when you run any kind of serious web development setup. I usually run multiple Docker containers, Chrome/Safari windows, the [Webstorm IDE](https://www.jetbrains.com/webstorm/) with plenty of plugins and the occasional database management tool. On top of all that there is constant screen sharing due to remote work, which is taxing since I use a couple of LG Ultrafine monitors. The result is fans at max speed from the moment I turned on the computer until I close it down at the end of the work day, and a battery life of less than an hour.

After I switched to a 14'' M1 Pro MacBook Pro, the situation is the opposite. Absolute silence, laptop cool to the touch, and a super fluid experience even when running the most demanding tasks. Apple Silicon is nothing short of a revolution in my opinion.

## About Docker Volumes

A Docker Volume can be seen, in a very simplified manner, as a *mounted* folder inside a container. When the container starts up, a path (folder or file) in the container will be __replaced__ with a folder or file present in the host. This is what allows the separation of code from data that Docker is famous for. While the data (state of the application) is safely in the host, the code and all its dependencies are packaged in the image that serves as the template for the container to be created. 

Some years ago I wrote some [classroom keynote slides](https://silvae86.github.io/teaching/slides/docker/basics/#13) that provide a basic introduction to Docker volumes and other Docker concepts.

## Challenges posed by M1 Macs in the dev environment

Most laptops/desktops commonly used as development machines are built on the x86 architecture. Up until very recently, Apple also used Intel processors based on x86, or more specifically x86_64 (x86 with 64-bit extensions) in most of its computer products.

## Approaches for Node apps

Node apps commonly rely on a `node_modules` folder that contains all the NPM packages that the app relies on. The fact that this folder commonly resides in a subfolder of the app itself requires some thinking when building a Docker image for your app. You will very likely mount a volume in the container containing your source code. As a consequence, you will have to run `npm install` in the container. This not only does not take advantage of efficient image layer caching, but also requires a propagation of the resulting `node_modules` subfolder from the container's file system to the host's filesystem through the mounted volume. Such I/O operations are __unusably__ slow on a Mac. 

When all development workstations are X86 based, you can get away with installing all your modules locally (`<app-root>/node_modeles`)and just mounting the whole `<app_root>` somewhere in the container to start your app. Both the container and the host share the same architecture. 

The problems arrise when 


## VirtioFS accelerated directory sharing

Starting with macOS 12.2 Monterey, Docker offers 

### Caching the `.npm` folder

## Structuring Docker Compose files: generic and architecture-specific

## Establishing image dependencies

## Testing results