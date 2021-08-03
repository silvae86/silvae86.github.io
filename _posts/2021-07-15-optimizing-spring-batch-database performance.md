---
layout: post
title:  "How to optimize Spring Batch performance using indexes"
date: 2021-07-15 22:07:000 +0100
tags: postgresql indexes optimization performance
published: false
---

Slow queries are commonly easy to identify, since they take at least seconds or minutes to run. Here I show a different type of optimization procedure for queries that are not expensive when ran once or twice, but that can take a toll on a system if ran many times. Here I will use the database schema of the Spring Batch framework, using PostgreSQL, by following these steps:

1. Set up a custom `postgresql.conf` configuration file to enable the necessary diagnostics extension
2. Boot up a PostgreSQL Docker container 
3. Enable the diagnostics extension using the command line
4. Run The Best Query In The World™
   - The credits for what can arguably be considered the "the best query in the world" go to Hans-Jurgen Schonig.
5. Analyse results
6. Spot expensive operations and design the appropriate indices to speed up the queries
7. Results analysis

## Set up a custom configuration file




## The best query in the world

