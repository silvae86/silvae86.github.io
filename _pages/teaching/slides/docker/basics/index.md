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
[a container runtime for software deployments]

## Concepts and Introduction
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
## Why Docker? (1/2)

- .good[**Flexibility**]
	- Practically any application can be containerized
- .good[**Lightweight**]
	- Containers share the host Kernel, without virtualizing an OS for every application, saving resources
- .good[**Portability**]
	- Ensures portability of execution environment on any machine
	- Application, pre-requisites and dependencies are packaged together
- .good[**Scalability**]
	- From a single container on your laptop or thousands in the cloud, it is all the same technology
- .good[**Loose coupling**]
	- Containers are highly self-sufficient and encapsulated, and can be updated individually without upsetting others
- .good[**Security**]
	- Containers apply aggressive constraints and isolations to processes without any configuration required on the part of the user.


.footnote[.tiny[Source: "Orientation and setup", by [Docker](https://docs.docker.com/get-started/)]].

---
name: why-2
## Why Docker? (2/2)

- .good[**Elasticity for the cloud**]
	- In the cloud, computational resources should be purchased as needed
	- Too many users for too little computational power &rarr; poor system performance
	- Too many resources for too little users &rarr; waste of money
	- Docker makes it easier to scale applications up to meet peak loads, and then scale down during downtime
		- Spin up more or less containers (*replicas* of the application) across a datacenter, to respond to application loading

- .good[**Separation of code from state**]
	- Separates code+infrastructure (*application logic*) configuration from Data (*application state*)
	- Backups only need to worry about the data, as code and infrastructure can be built on-the-fly

- .good[**Native CPU scheduling**]
 	- On Linux, containers are seen by the Kernel as independent processes, so they can be efficiently managed by the CPU scheduler

---
name: virtual-machines
## Virtual Machines (1/2)

### What are they?

- A virtual machine is a software that *simulates* a physical computer's hardware and software components

### Host vs. Guest

- Several **virtual** machines can run in a single **physical**, or *bare metal* machine
	- Virtual machines are typically called "guests"
	- The physical machines where they run are called "hosts"

---
name: virtual-machines-2
## Virtual Machines (2/2)

### The hypervisor
- The *hypervisor* is the software that powers the virtual machines
	- It provides virtual networking and storage layers (virtual network cards and virtual hard drives)
	- Controls how much % of CPU and RAM of the host is given to each of the guests


---
name: virtual-machines-advantages-disadvantages
## Virtual machines vs. 'bare-metal'

### .good[Advantages]
- Portability and hardware-agnosticism
	- The same VM can run in computers with very different hardware and software configurations
	- The *hypervisor* provides an abstraction layer between the virtual and physical hardware configurations
- Faster disaster recovery
	- Virtual machines can be backed up
- Isolation
	- Improved security for shared hardware machines-several users can have full administration privileges inside their own VMs, but without any access to the host
	- VMs make it easier to set up a *multi-tenant* environment, where resources are shared among the various VMs, which can even belong to different people.

---
name: virtual-machines-advantages-disadvantages-2
## Virtual machines vs. 'bare-metal'

### .bad[Disadvantages]
- High resource consumption
	 - The physical machine needs to virtualise everything, including the operating system - RAM usage is the same as that of a 'bare-metal' machine. The host needs a lot of RAM to run several VMs at the same time.
	 - Running many VMs on the same host can slow down even powerful servers, because the access to hard drive needs to be split among multiple concurrent and random accesses--- this is especially hard on mechanical hard drives, not so much on SSDs.
- Lack of access to some low-level functions
	- If your application needs direct access to some low-level / hardware capabilities (such as 3D acceleration), those may be unavailable.
- Backups need to include the entire virtual machine
	- Very large files, as the virtual machine "virtual hard drive" takes as much space as an entire hard drive of a 'bare-metal' machine (~hundreds of GB **each**!).

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

- Containers does not need to virtualize the Operating System, saving memory
- Containers share the host's operating system and *kernel*

---
name: architecture
## Architecture

.width100[
	.center[
		!["Docker Architecture"](/teaching/slides/docker/basics/architecture.png)
	]
]

- An overview of the Docker architecture (Image by Docker - [Source](https://docs.docker.com/get-started/overview/))

---
name: images
## Images

- Read-only **templates** with instructions for creating a Docker container
- Often based on other images. e.g. : you can start with from a `ubuntu` image (*base image*) and install additional libraries, resulting in a new image.
	- Steps to go from one image to another are like *layers*, because an image is like an onion: made up of several successive sets of changes.
	- When images are rebuilt, only the modified layers are remade, and the base image recovered from *cache*. This makes image building much more efficient than building a VM using, say, [Vagrant](https://www.vagrantup.com/).
- Images are built using [Dockerfiles](#dockerfile), written as a sequence of steps to go from the *base image* to your final image. Every step in a Dockerfile creates a new *layer*.
- You can `pull` them from an image registry, i.e. [Docker Hub](https://hub.docker.com/search?q=&type=image&image_filter=official), or build and `push` your own to Docker hub to publish your work.

---
name: containers
## Containers

- Containers are a runnable *instance* of an image.
	- Instance because you can start __multiple containers__ from the same image---like baking cookies from the same mold!
- You can `start`, `stop`, `move`, or `delete` containers using the `docker` command.
- Connectors can be connected to one or more *networks*---separate them for security via isolation, or connect them so they work together
- Attach storage to the container via **volumes**---like plugging in an external hard drive to keep changed files after the container is shut down.
- You can `save` a new image from the current state of a container.

.dangerbox[If you `start` a container from an image and anything is modified inside the container, all will be lost when you `stop` and `rm` it.]
---
name: volumes
## Volumes


---
name: networking
## Networks



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
