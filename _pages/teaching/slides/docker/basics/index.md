---
layout: keynote
title: Docker Basics
permalink: /teaching/slides/docker/basics/
---
{% highlight text %}
{% raw %}
name: docker
class: middle, center
template:inverse

# Docker
[container runtime for portable and scalable application deployment]

## Introduction and Basics
by [João Rocha da Silva](https://silvae86.github.io), based on ['Using Docker: Developing and Deploying Software with Containers'](https://www.oreilly.com/library/view/using-docker/9781491915752/) by *Adrian Mouat* and [other sources](#references).

---
name: agenda
class: middle, center

## Agenda
.index[

.indexpill[[About](#about)]

.indexpill[[Why Docker?](#why)]

.indexpill[[Virtual Machines](#virtual-machines)]

.indexpill[[VM Hypervisor vs Docker Runtime](#hypervisor-vs-docker)]

.indexpill[[Images](#images)]

.indexpill[[Containers](#containers)]

.indexpill[[Volumes](#volumes)]

.indexpill[[Dockerfiles](#dockerfile)]

.indexpill[[Docker compose](#compose)]

.indexpill[[Docker Hub](#docker-hub)]

.indexpill[[Example container (Web Server)](#example)]

.indexpill[[Installation](#installation)]

.indexpill[[TL;DR](#tl-dr)]

.indexpill[[References](#references)]

]

---
name: why
## Why Docker?

- Separates Code + Infrastructure from Data (*state*)
- Ensures portability of execution environment (no more "works on my machine!")
- Facilitates scalability of solutions

---
name: virtual-machines
## Virtual Machines


---
name: hypervisor-vs-docker
## VM Hypervisor vs Docker Runtime

.width80[
	.center[
		<section>
		    <img width="47%" src="/teaching/slides/docker/basics/container-engine.png" alt="Container Engine Architectural Diagram">
		    <img width="47%" src="/teaching/slides/docker/basics/vms.png" alt="Virtual Machines Architectural Diagram">
		</section>
	]
]

- Containers does not need to virtualize an Operating System
- Containers share the host's *kernel*

---
name: architecture
## Architecture

.width100[
	.center[
		<section>
		    <img width="47%" src="/teaching/slides/docker/basics/architecture.svg" alt="Docker Architecture">
		</section>
	]
]

- An overview of the Docker architecture (Image by Docker - [link](https://docs.docker.com/get-started/overview/))

---
name: images
## Images

---
name: containers
## Containers


---
name: volumes
## Volumes


---
name: networking
## Networking


---
name: commands
## Commands


---
name: dockerfile
## The Dockerfile


---
name: docker-compose
## Docker Compose

---
name: references
## References

- *Using Docker: Developing and Deploying Software with Containers*
	Mouat, A. (2016).  
	O'Reilly Media, Inc.

- *Docker Overview*
	Docker Docs  
	[https://docs.docker.com/get-started/overview/](https://docs.docker.com/get-started/overview/)

{% endraw %}
{% endhighlight %}
