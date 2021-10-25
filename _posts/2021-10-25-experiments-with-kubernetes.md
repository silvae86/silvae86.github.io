---
layout: post
title:  "Experiments with Kubernetes"
date: 2021-10-25 21:46:000 +0100
tags: kubernetes technology experiments docker docker-compose
published: false
---

Kubernetes is "an open-source platform for managing containerized workloads and services". It is an awesome solution for Continuous Integration! Among many other things, you can deploy newer versions of services with zero downtime, scale workloads to multiple machines, and fallback to a stable version if a deployment goes badly or the newer version happens to crash.

Minikube sets up a single-node Kubernetes cluster that makes it easier to develop for a Kubernetes environment on a local machine. It's also a great way to learn Kubernetes, so we will start here.

## Install Kubernetes, MiniKube and Kubernetes Dashboard

Let's install Kubernetes and Minikube. Here I am using a Mac and Homebrew:

```shell
brew install docker
brew install kubernetes-cli
brew install minikube
```

## Translating a `docker-compose.yml` file for use in Kubernetes

Being a daily user of Docker and Docker Compose, I learned to build my own `docker-compose.yml` files. They allow one to 

## References 

["Cheatsheet for Kubernetes (MiniKube & Kubectl)"](https://medium.com/geekculture/cheatsheet-for-kubernetes-minikube-kubectl-5500ffd2f0d5)
["What is Kubernetes?"](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)
["Minikube"](https://minikube.sigs.k8s.io/docs/)



