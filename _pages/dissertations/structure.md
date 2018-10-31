---
layout: page
title: Dissertation report structure
---

## Is there a template?

Ask your supervisor if there is an established document template for the dissertation. In the case of FEUP's Masters in Informatics Engineering, the template is available at [Prof. João Correia Lopes' website](https://web.fe.up.pt/~jlopes/doku.php/teach/feupteses).

## Introduction

### Context

This should provide a short introduction of the research domain, applications and overall interest of the problem being studied.

### Motivation

(Why is the work needed? What is the perceived impact to the research/industry community to which it contributes?. This can be replaced with a section title that more closely matches the description of the problem).

### Objectives

(Objective tree, dividing a main, broad, high level objective into sub-objectives which can even become milestones at a later time. The objective tree helps to frame the work and can include objectives that other research or tech solutions have already achieved, the goals and subgoals to be achieved by this dissertation, and future goals that can be pursued as future work and which are outside of the scope of the dissertation). The objective tree should be represented in a tree-like diagram, which is later clearly read and explained in the text, listing every objective and its relationships with the parent and sibling objectives. The text should also clearly state which (sub) objectives are within the scope of the dissertation work and those which are outside, either because they were already achieved or because they are reserved as future work.

## State of the art or SOTA

This is an analysis and comparison of existing approaches, models technologies and tools related to the problem domain. It should provide an overview of the latest developments in research and industry, supporting the selection of a design approach and implementation approach, technological choices, experiment design, analysis and evaluation of results)...

Anyone reading your state of the art should not succumb to "death by citation overdose". This means that a good state of the art should not limit itself to referring the main contribution of a long list of papers. In fact, just citing a couple of sentences from a bunch of papers is worth very little.  Instead, try to relate what the authors say and comparing their approaches and conclusions. What do they have in common? What distinguishes them from each other?

For this, you need to find and read papers. Lots of papers. A good course of action to find related publications can be:

1.  Identify the research topics related to your own dissertation
2.  Identify the main conferences and journals related to your topic (a search on ACM Digital Library, Scopus)
4.  Search on Google Scholar for the most cited papers in those research topics, as they usually establish the base concepts of the research topic
3.  Search on Google Scholar for papers in the last 4 years, related to that topic, to broaden your research.

### SOTA of the high-level aspects of the domain of study (practices, methodology)
This should be an introduction to the domain(s) of study related to the problem at hand (If the work draws experience from different research domains, from the base science, theoretical approaches to architecture design and implementation, it can be interesting to provide a first section in the SOTA that helps the reader understand why the following sections are there, tying them up via a chronological and logical flow. Highlighting the evolution of the related domains of study, explaining why a certain topic is relevant to the problem and thus why it is included in the SOTA.

### SOTA on the technical approaches/platforms/software that supports the practices
The SOTA should have as many sections as needed (around 4 to 5 is a reasonable amount). The criteria is free, but each section should approach a domain or application related to the topic in question. For example, in a serious games and gamification dissertation, it could mean the theory behind serious games, the seminal works in the area, relevant concepts, academic experiments applying the concepts, and then moving on to industrial demonstrations of the application of such theories. Evaluation methods can and should also be included in the SOTA, to highlight how related works were evaluated, draw experience from them, which can later assist in the design of our own experiment, supporting our decisions in the choices made in past works (if it worked well for solid publications, then it might work in our case too). At the end of each section, the

## Proposed approach
Detail how you are going to develop a

## Implementation
In an Informatics Engineering MSc dissertation, it is common to have to implement a prototype of some sort, in order to build a testbed for your approach. This can be an addition to an existing software solution---in which the technological stack will already be pre-defined---or a completely new piece of software, for which you will have to select the most appropriate technologies at every level of the tech stack.

## Evaluation

When preparing your dissertation, I believe the entire work should be driven by the design of an experiment that will enable you to prove how effective your approach is at solving the problem that you are tackling.

To design a good experiment you should establish:

1. Your *baseline*. A baseline is, so to speak, the "base of comparison" or "current state of affairs" before your work is introduced. In a research context, it is usually drawn from the state of the art.
2. Your *evaluation metric*. In order to quantify the degree of improvement introduce by your approach, you need to establish the metric through which you compare the baseline with the Is it the time a certain user takes to perform a task? How fast an al


### Experiment configuration

### Results analysis

### Conclusions and discussion


## Conclusions and future work
