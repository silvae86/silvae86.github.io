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

.indexpill[[VMs vs. 'bare metal'](#virtual-machines-vs-bare-metal)]

.indexpill[[VMs vs Containers](#vms-vs-containers)]

.indexpill[[Images](#images)]

.indexpill[[Containers](#containers)]

.indexpill[[Volumes](#volumes)]

.indexpill[[Networking](#networking)]

.indexpill[[Commands](#common-commands)]

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
- Makes it easi*er* to scale solutions dynamically by running more or less containers
	- Solution can handle more or less users as needed
	- Important for the cloud, where resources (and the costs!) are dynamic

---
name: virtual-machines
## Virtual Machines

- A virtual machine is a software that *simulates* a computer's hardware and software components
- Several virtual machines can run in a single physical, or *bare metal* machine
	- Makes it easy to set up a *multi-tenant* environment, where resources are shared among the various VMs, which can even belong to
- The *hypervisor* is the software that powers the virtual machines
	- It provides virtual networking and storage layers (virtual network cards and virtual hard drives)
	- Controls access to CPU and memory of the physical machine
- Virtual machines

---
name: virtual-machines-vs-bare-metal
## VM vs. Bare Metal

Advantages and disadvantages of running virtual machines over 'bare metal'

.left[
### Advantages
- Portability and hardware-agnosticism
	- The same VM can run in computers with very different hardware and software configurations
	- The *hypervisor* provides an abstraction layer between the virtual and physical hardware configurations
- Faster disaster recovery
	- Virtual machines can be backed up
- Isolation
	- Improved security for shared servers, as several users can have full administration previledges their own VMs
- Abstraction
	-
]

.right [
### Disadvantages
- High resource consumption
	 - The physical machine needs to virtualize everything, including the operating system
- Lack of access to some low-level functions
	- Everything is virtualized,
]

---
name: vms-vs-containers
## VMs vs Containers (Cont'd)

.width80[
	.center[
		<section>
		    <img width="47%" src="/teaching/slides/docker/basics/container-engine.png" alt="Container Engine Architectural Diagram">
		    <img width="47%" src="/teaching/slides/docker/basics/vms.png" alt="Virtual Machines Architectural Diagram">
		</section>
	]
]

- Containers does not need to virtualize the Operating System
- Containers share the host's operating system and *kernel*

---
name: vms-vs-containers-2
## VMs vs Containers (Cont'd)

Advantages and disadvantages of running containers when compared to virtual machines

.left[
### Advantages
- Vast reduction in resource usage
- Much faster spin up and spin down than a VM
]

.right [


]

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
## Common commands


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
