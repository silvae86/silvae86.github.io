---
layout: post
title:  "How to run a command in a Docker container (or how to SSH into a Docker container)"
date:   2018-07-09 17:04:00 +0100
tags: sysadmin docker container ssh
---

Docker containers can be a great way to try out some scripts before they are ready for production. One of the basic tasks is to run a command in a specific container. Here is how to do it.

## Get the ID of the container you want to SSH into

```shell
docker ps
```

You should get something like this:

```shell
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                                            NAMES
347f111f3112        joaorosilva/mongodb:3.7-no-volumes                    "docker-entrypoint.s…"   5 days ago          Up 6 hours          0.0.0.0:27017->27017/tcp                         mongodb-dendro
14ad46120a7a        joaorosilva/mysql:8.0-no-volumes                      "docker-entrypoint.s…"   5 days ago          Up 6 hours          0.0.0.0:3306->3306/tcp                           mysql-dendro
cee3f8ee57d0        joaorosilva/virtuoso:7.2.4-for-dendro-0.3             "/bin/bash /virtuoso…"   5 days ago          Up 6 hours          0.0.0.0:1111->1111/tcp, 0.0.0.0:8890->8890/tcp   virtuoso-dendro
4e54faa904eb        docker.elastic.co/elasticsearch/elasticsearch:6.2.2   "/usr/local/bin/dock…"   5 days ago          Up 6 hours          0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp   elasticsearch-dendro
```

## SSH into the container you want

See the ID of the container you want to SSH into. In this case, I want the `joaorosilva/elasticsearch/elasticsearch:6.2.2` container. Insert the ID into the command:

```shell
docker exec -it 4e54faa904eb /bin/bash
```

You will get a `root` command prompt.

```shell
➜  ~ docker exec -it 4e54faa904eb /bin/bash
[root@elasticsearch-dendro elasticsearch]#
```

If you want to run a different command, simply replace `/bin/bash` with the command you want. Be aware that it will be run as `root`.

Happy SSH'ing!