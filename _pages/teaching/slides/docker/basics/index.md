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

.center[.imgsm[!["Docker Logo"](/teaching/slides/docker/basics/docker-logo.png)]]
[a container runtime for software deployments]

## Concepts and Introduction
by [João Rocha da Silva](https://silvae86.github.io), based on ['Using Docker: Developing and Deploying Software with Containers'](https://www.oreilly.com/library/view/using-docker/9781491915752/) by *Adrian Mouat* and [other sources](#references).

---
name: agenda
class: middle, center

## Agenda
.index[

.indexpill[[Virtual Machines](#virtual-machines)]

.indexpill[[Virtual Machines vs. 'bare metal'](#virtual-machines-vs-bare-metal)]

.indexpill[[VM Hypervisor](#hypervisor)]

.indexpill[[Why Docker?](#why-docker)]

.indexpill[[VMs vs Containers](#vms-vs-containers)]

.indexpill[[Images](#images)]

.indexpill[[Containers](#containers)]

.indexpill[[Volumes](#volumes)]

.indexpill[[Networking](#networking)]

.indexpill[[Dockerfiles](#dockerfiles)]

.indexpill[[Installation](#installation)]

.indexpill[[Example container (Web Server)](#example)]

.indexpill[[References](#references)]

]

---
name: virtual-machines
## Virtual Machines

### What are they?

- A virtual machine is a software that *simulates* a physical computer's hardware and software components

### Host vs. Guest

- Several **virtual** machines can run in a single **physical**, or *bare metal* machine
	- Virtual machines are typically called "guests"
	- The physical machines where they run are called "hosts"

---
name: virtual-machines-vs-bare-metal
## Virtual machines vs. 'bare-metal' - Advantages

- .good[Portability and hardware-agnosticism]
	- The same VM can run in computers with very different hardware and software configurations
	- The [*hypervisor*](#hypervisor) provides an abstraction layer between the virtual and physical hardware configurations
- .good[Faster disaster recovery]
	- Virtual machines can be backed up and restored simply by copying and pasting their *virtual* hard drives, which are simple files on the host's file system.
- .good[Isolation]
	- Improved security for shared hardware machines-several users can have full administration privileges inside their own VMs, but without any access to the host
	- VMs make it easier to set up a *multi-tenant* environment, where resources are shared among the various VMs, which can even belong to different people.

---
name: virtual-machines-vs-bare-metal-2
## Virtual machines vs. 'bare-metal' - Disadvantages

- .bad[High resource consumption]
	 - The physical machine needs to virtualise everything, including the operating system - RAM usage is the same as that of a 'bare-metal' machine. The host needs a lot of RAM to run several VMs at the same time.
	 - Running many VMs on the same host can slow down even powerful servers, because the access to hard drive needs to be split among multiple concurrent and random accesses--- this is especially hard on mechanical hard drives, not so much on SSDs.
- .bad[Lack of access to some low-level functions]
	- If your application needs direct access to some low-level / hardware capabilities (such as 3D acceleration), those may be unavailable.
- .bad[Backups need to include the entire virtual machine]
	- Very large files, as the virtual machine "virtual hard drive" takes as much space as an entire hard drive of a 'bare-metal' machine (~hundreds of GB **each**!).

---
name: hypervisor
## The hypervisor
- Software that powers the virtual machines
- It provides virtual networking and storage layers (virtual network cards and virtual hard drives)
- Controls how much % of CPU and RAM of the host is given to each of the guests

<br>
<br>


.cols[
.fifty[
.center[
.imgmd[!["VMWare Logo"](/teaching/slides/docker/basics/vmware-logo.png)]

.tiny[[VMWare Workstation by VMWare](https://www.vmware.com/)]
]
]
.fifty[
.center[
.imgmd[!["VirtualBox Logo"](/teaching/slides/docker/basics/virtualbox-logo.png)]

.tiny[[VirtualBox by Oracle](https://www.vmware.com/) - 
(Open source hypervisor)]
]
]
]

---
name: why-docker
## Why Docker? (1/2)

- .good[**Flexibility**]
	- Practically any application can be containerized
- .good[**Lightweight**]
	- Containers share the host Kernel, without virtualizing an OS for every application, saving a LOT of resources when compared to using Virtual Machines
- .good[**Portability**]
	- Ensures portability of execution environment on any machine
	- Application, pre-requisites and dependencies are packaged together
- .good[**Scalability**]
	- From a single container on your laptop or thousands in the cloud, it is all the same technology
- .good[**Loose coupling**]
	- Containers are highly self-sufficient and encapsulated, and can be updated individually without upsetting others
- .good[**Security**]
	- Containers apply aggressive constraints and isolations to processes without any configuration required on the part of the user.

.tiny[.footnote[Source: "Orientation and setup", by [Docker](https://docs.docker.com/get-started/)]]

---
name: why-docker-2
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
name: vms-vs-containers
## VMs vs Containers (Cont'd)

.center[
.cols[
.fifty[
.center[
.imgmd2[![Container Engine Architectural Diagram](/teaching/slides/docker/basics/container-engine.png)]
]
]
.fifty[
.center[
.imgmd2[![Virtual Machines Architectural Diagram](/teaching/slides/docker/basics/vms.png)]
]
]
]
]

- Containers share the host's OS and kernel, and do not need to virtualize the Operating System &rarr; saving memory

.footnote[.tiny[Images from [*Using Docker: Developing and Deploying Software with Containers*](#references)]]

---
name: architecture
## Architecture

.center[
.imgfull[!["Docker Architecture"](/teaching/slides/docker/basics/architecture.png)]

.tiny[An overview of the Docker architecture (Image by Docker - [Source](https://docs.docker.com/get-started/overview/))]
]

---
name: images
## Images

.cols[
.fifty[
	.center[
		.imgmd[!["Docker Images"](/teaching/slides/docker/basics/architecture-images.png)]
		.tiny[Docker Images (Based on an image by Docker - [Source](https://docs.docker.com/storage/volumes/))]
	]
]
.fifty[
- Read-only **templates** with instructions for creating a Docker container
- Images are built using [Dockerfiles](#dockerfile), written as a sequence of steps to go from the *base image* to your final image. Every step in a Dockerfile creates a new *layer*.
- You can `pull` them from an image registry, i.e. [Docker Hub](https://hub.docker.com/search?q=&type=image&image_filter=official), or build and `push` your own to Docker hub to publish your work.
]
]

- Often based on other images. e.g. : you can start with from a `ubuntu` image (*base image*) and install additional libraries, resulting in a new image.
	- Steps to go from one image to another are called *layers*, because an image is like an onion: made up of several successive sets of changes.
	- When images are rebuilt, only the modified layers are remade, and the base image recovered from *cache*. This makes image building much more efficient than building a VM using, say, [Vagrant](https://www.vagrantup.com/).

---
name: containers
## Containers

.cols[
.fifty[
.center[
.imgmd[!["Docker Containers"](/teaching/slides/docker/basics/architecture-containers.png)]

.tiny[Docker containers (Based on an image by Docker - [Source](https://docs.docker.com/storage/volumes/))]
]
]
.fifty[
- Containers are a runnable *instance* of an image.
	- Instance because you can start __multiple containers__ from the same image---like baking cookies from the same mold!
- You can `start`, `stop`, `move`, or `delete` containers using the `docker` command.
]
]

- Connectors can be connected to one or more [*networks*](#networking) &rarr; separate them for security via isolation, or connect them so they work together
- Attach storage to the container via [**volumes**](#volumes) &rarr; like plugging in an external hard drive to keep changed files after the container is shut down.
- You can `save` a new image from the current state of a container.

.dangerbox[If you `start` a container from an image and anything is modified inside the former, all changes be lost when you `stop` and `rm` (remove) it.]

---
name: volumes
## Volumes (1/4) - What are they?

.center[
.imgmd[!["Docker Volumes"](/teaching/slides/docker/basics/types-of-mounts-volume.png)]

.tiny[Docker volumes (Image by Docker - [Source](https://docs.docker.com/storage/volumes/))]
]

- Without volumes, containers contain both application code and state (no separation)
	- When the container is deleted, so are any changes made since its instantiation from its base image
- A volume acts a like a *mount point* for a container
	- It "injects" a link to a folder from the host machine into the container's file structure
	- That becomes a shared folder between host and container
	- You can also use `tmpfs` in Linux to create a memory-based volume for using RAM as a virtual file structure 
		- Fast!! But volatile too, good for caching files, for example

---
## Volumes (2/4) - Advantages and Disadvantages

.center[
.imgmd[!["Docker Volumes"](/teaching/slides/docker/basics/volumes-shared-storage.png)]

.tiny[Docker volumes (Image by Docker - [Source](https://docs.docker.com/storage/volumes/))]
]

- .good[Sharing data across different containers and machines]
	- Good for fault-tolerant applications---if one containerized "clone" of your application crashes, another can over transparently, because they share the same data, or *state*
- .good[Access control]
	- Volumes are **bidirectional** be default: changes made by the host to files inside the volume folder are also propagated inside the corresponding folder in the container (and vice-versa)
	- `readonly` volumes will allow the container to read files in the volume, but not change them

---
## Volumes (3/4) - Advantages and Disadvantages Part 2

- .good[Very useful for backups]
	- You link only the folders within the container that have your application state (say, the folders where you have database files, uploaded images, and any other) 
	- Ignore the rest of the operating system in each container, because all dependencies are handled by the image---great space savings
	- To backup, instead of making an image of the entire container, you just copy the volume folders in the host
	- To go back in time, just replace the volume folders' content with your backup and start a new container with those volumes mounted.

- .bad[Slow I/O on non-Linux Operating Systems] 
	- Read and write to/from volume folders can be quote slow on non-Linux operating systems. Watch out if you need intensive I/O in your app.

---
## Volumes (4/4) - Initialization of containerized applications .tiny[from "Stuff I learned the hard way, page 3519"] 

.dangerbox[Volumes are mounted when a container is booted, **replacing the contents** of the folder in the container with the contents of the volume folder from the host]

.small[
1. If you need to initialize your app automatically on first startup (e.g. create default admin users), you cannot do it during image creation, but instead use a startup script inside the container. 
	- This is because our application state (e.g. some database files) is saved in a folder somewhere in the container. If you initialize those files during the image building process, apparently everything works well **without volumes**. 
2.  When that folder is later mounted as a volume, its contents **will be replaced** with the contents of the host's folder that is mounted
	- .red[Down the 🚽 goes your initialization], as the mounted volume's folder is most likely empty when it is mounted by the host in the container on first startup!
3.  Possible generic solution: Create a dummy file in your data folder after a successful initialization. Let your initialization code check if the file is present. If it is not, then you need to re-initialize. Changes will be propagated to the volume's folder on the host, so this should only happen on first bootup. 
	- Alternatively, some web frameworks also provide support for database *migration* and *seeding*, that you can run on application startup.
]

---
name: networking
## Networking

- Docker containers can live on the same network as other VMs, bare-metal machines, or containers
	- All types of machines can communicate transparently
- 5 networking modes: `bridge`, `host`, `overlay`, `macvlan` and `none`
	- `none` will disable networking completely-no communication
- We will cover the two most common ones, `bridge` and `host`.

.footnote[.tiny[Source: [https://docs.docker.com/network/](https://docs.docker.com/network)]]

---
name: networking-bridge
## Networking (`bridge` mode)

.cols[
.fifty[
.center[
.imgmd[!["Docker Networking - Bridge Mode"](/teaching/slides/docker/basics/docker-networks-bridge.png)]

.tiny[Docker Networking ([Bridge mode)](https://docs.docker.com/network/bridge/)]
]
]
.fifty[
- Containers running on Bob host can find other containers also running on Bob by name (running `ping solr` on `my-app` container will return the IP of `my-app`, as given by the Docker DHCP server).
- Alice cannot find a container by name (`ping solr` on Alice's machine will return Host Not Found).
- Containers can find Alice by name (`ping alice` will return alice's IP, as given by Internet Gateway) and access the Internet.
- Containers running in the Bob host cannot find any containers running on Alice
- Multiple `bridge` networks can be created, and containers can will communicate within the same `bridge` network (for separation).
]
]

---
name: networking-host
## Networking (`host` mode)

.cols[
.fifty[
.center[
.imgmd[!["Docker Networking - Host Mode"](/teaching/slides/docker/basics/docker-networks-host.png)]

.tiny[Docker Networking ([Host mode)](https://docs.docker.com/network/host/)]
]
]
.fifty[
- Only available on Linux
- Containers on Bob host can access the host network directly.
- No name resolution among containers
	- `my-app` running on Bob will not get any response if it runs `ping mysql`
	- DNS entries (such as `bob.lan <ip>`) must be added at the physical network host resolution level
- Containers can bind their open ports to ports on the host. 
	- Alice can access a container on Bob via Bob's IP + port of the container they want
	- Only one program (and thus, only one container) can be listening on a port of each host. Beware of conflicts! 
]
]

---
name: dockerfiles
## Dockerfiles

- Dockerfiles are files containing the sequence of steps required to build an image. 
- They are typically named `Dockerfile` without any extension.

.small[
````dockerfile
# Start with a base image of Ubuntu 18.04, then:
FROM ubuntu:18.04			
# Copy current folder on the host to /app on the container
COPY . /app
# run `make` (compilation, etc) on  /app to build the app on the container
RUN make /app				
# Set default command when container boots up (runs installed app)
CMD python /app/app.py		
````
]

To build an image from a `Dockerfile` in the current directory, you run:

.small[
````shell
docker build .
````
]

- More complicated `Dockerfile` examples can be found [here](https://github.com/silvae86/feup-bdad-corrector/blob/master/Dockerfile) and [here](https://github.com/feup-infolab/dendro/blob/master/Dockerfile) if you are curious.
- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [`docker build` command reference](https://docs.docker.com/engine/reference/commandline/build/)
---
name: installation
## Installation

- Installation guide for Docker and how to use a container for local PHP development available [here](/teaching/howto/local_dev_with_docker).

.warningbox[Remember to turn on Virtualization Support (or VT-x) on your BIOS/ UEFI (press Delete/F2 before Windows Starts) in order to run virtualization apps like Docker or a VM Hypervisor. See more [here](https://docs.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/sect-Virtualization-Troubleshooting-Enabling_Intel_VT_and_AMD_V_virtualization_hardware_extensions_in_BIOS.html).]

.center[
.imglg[!["Virtualization Off - Docker Error"](/teaching/slides/docker/basics/docker-no-virtualization.png)]

.tiny[Oops, I forgot to [turn on Virtualization](https://docs.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/sect-Virtualization-Troubleshooting-Enabling_Intel_VT_and_AMD_V_virtualization_hardware_extensions_in_BIOS.html)!]
]

---
name: example
## Example Container (Apache Web Server + PHP)

- The command that you use to start your server, now explained:

.small[
```sh
docker run 		 				\ #
									\ # run is the command for running a container
	-d 			 				\ #
									\ # run in detached mode (without this, 
									\ # the container will stop when you close the 
									\ # command line, instead of running in 
									\ # the background and on system startup)
	-p 8080:8080					\ #
									\ # bind port 8080 of the container, 
									\ # which is running the Apache+PHP server, 
									\ # to the port 8080 of the host. This is 
									\ # what allows you to type localhost:8080 
									\ # on the browser and have the container respond
	-it 							\ #
									\ # allocate a tty for the container process 
	--name=php 	 				\ #
									\ # name of the container to create 
	-v $(pwd)/html:/var/www/html	\ #			
									\ # create a volume to map 
									\ # [current folder]/html on the 
									\ # host to /var/www/html (default Apache 
									\ # htdocs location) on the container
	quay.io/vesica/php73:dev		#
									# name of the image to base 
									# the container on (has Apache and PHP 
									# pre-installed)
```
]

.footnote[.tiny[
- [`docker run` command reference](https://docs.docker.com/engine/reference/run/)
- [What is a TTY?](https://www.howtogeek.com/428174/what-is-a-tty-on-linux-and-how-to-use-the-tty-command/)
]]

---
name: references
## References

- *Using Docker: Developing and Deploying Software with Containers*
	Mouat, A. (2016).
	O'Reilly Media, Inc.

- *Docker Overview*
	Docker Docs
	[https://docs.docker.com/get-started/overview/](https://docs.docker.com/get-started/overview/)

- *Docker Networking*
	Docker Docs
	[https://docs.docker.com/network/](https://docs.docker.com/network/)

- *Most common Docker commands*
	[Docker Cheat Sheet](https://github.com/wsargent/docker-cheat-sheet)

{% endraw %}
{% endhighlight %}
