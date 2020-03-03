---
layout: page
title: Dissertation report structure
---

{% include warning.html content="Page in construction!" %}

## Before you start: is there a template?

Ask your supervisor if there is an established document template for the dissertation. In the case of FEUP's Masters in Informatics Engineering, the template is available at [Prof. João Correia Lopes' website](https://web.fe.up.pt/~jlopes/doku.php/teach/feupteses).

## Introduction

The introduction is the first chapter of a dissertation, and should be able to "set a frame" a around your work. 

This "Context" should be a high-level description of the problem, why a solution is needed and who needs it (stakeholders?). It should be broad enough to allow someone with overall knowledge of your research domain to understand what it is about (say, if you are writing for an Informatics Engineering MSc dissertation, an Informatics Engineer should be able to grasp the idea), and then proceed to the more specific aspects of the particular research. Avoid jargon in the Context section, or if you must use it, please explain it appropriately.

### Context

This should provide a short introduction of the research domain, applications and overall interest of the problem being studied.

### Motivation

(Why is the work needed? What is the perceived impact to the research/industry community to which it contributes?. This can be replaced with a section title that more closely matches the description of the problem).

### Objectives

(Objective tree, dividing a main, broad, high level objective into sub-objectives which can even become milestones at a later time. The objective tree helps to frame the work and can include objectives that other research or tech solutions have already achieved, the goals and subgoals to be achieved by this dissertation, and future goals that can be pursued as future work and which are outside of the scope of the dissertation). The objective tree should be represented in a tree-like diagram, which is later clearly read and explained in the text, listing every objective and its relationships with the parent and sibling objectives. The text should also clearly state which (sub) objectives are within the scope of the dissertation work and those which are outside, either because they were already achieved or because they are reserved as future work.

#### Hypothesis and research questions

It is often interesting to frame your objectives around a hypothesis, which is what you want to prove via experimental or observational processes. A hypothesis is something that you assume to be true, and then carry out experiments under that assumption. If they turn out to prove your hypothesis, you achieve your research goal. For example: "It is possible to reduce the execution time of software tests through a state caching mechanism built on microservices" (somewhat inspired by [this dissertation](https://repositorio-aberto.up.pt/handle/10216/122203) that I supervised in 2018). 

The hypothesis is a statement that expresses a high-level problem, while research questions are smaller "components" of the process that one must follow in order to prove the hypothesis. Say for example that, in order to prove your hypothesis, you follow an experimental method that requires the construction of a prototype that involves a new technology, you may state a research question RQ1 (it is good to name them so you can later refer to them in the text) like this: "Can Technology X, normally used in applications of type Y be applied in the context of Z?". Another RQ2. "How does the execution time of tests scale as we increase the number of containers and the number of cores in an experimental scenario?".

As you see, answering your Research Questions, if they are properly formulated, is a way to prove your hypothesis in a structured way.

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
The SOTA should have as many sections as needed (around 4 to 5 is a reasonable amount). The criteria is free, but each section should approach a domain or application related to the topic in question. For example, in a serious games and gamification dissertation, it could mean the theory behind serious games, the seminal works in the area, relevant concepts, academic experiments applying the concepts, and then moving on to industrial demonstrations of the application of such theories. Evaluation methods can and should also be included in the SOTA, to highlight how related works were evaluated, draw experience from them, which can later assist in the design of our own experiment, supporting our decisions in the choices made in past works (if it worked well for solid publications, then it might work in our case too). 

At the end of each section, there should be a short conclusion to remind the reader of everything they just read, as well as a critical analysis of the current approaches. Maybe you can also hint at what approach you will adopt (or adapt) from existing literature, forming a bridge between this section and the next one (Proposed Approach).

## Proposed approach

Detail how you are going to achieve your dissertation's goals. Typically you need to state what will be your methology (experimental (usually in engineering it is this)? observational? empyrical?)

Are you supposed to develop a prototype? Or gather requirements for a development at a company? What techniques exist to the pursuit of these goals? How are you going to adapt/combine them?

## Implementation
In an Informatics Engineering MSc dissertation, it is common to have to implement a prototype of some sort, in order to build a testbed for your approach. This can be an addition to an existing software solution---in which the technological stack will already be pre-defined---or a completely new piece of software, for which you will have to select the most appropriate technologies at every level of the tech stack.

## Evaluation

When preparing your dissertation, I believe the entire work should be driven by the design of an experiment that will enable you to prove how effective your approach is at solving the problem that you are tackling.

To design a good experiment you should establish:

1. Your *baseline*. A baseline is, so to speak, the "base of comparison" or "current state of affairs" before your work is introduced. In a research context, it is usually drawn from the state of the art.
2. Your *evaluation metric*. In order to quantify the degree of improvement introduce by your approach, you need to establish the metric through which you compare the baseline with the Is it the time a certain user takes to perform a task? How much faster your algorithm performs against the baseline (which should be the current best in the state of the art, for a particular scenario or problem)?


### Experiment configuration

### Results analysis

### Conclusions and discussion


## Conclusions and future work
