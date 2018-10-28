---
layout: page
title: Supervision
include_in_menu: true
---

I have supervised several MSc dissertations at FEUP, both in Information Science and Informatics Engineering. Based on these, I have compiled several guidelines for new MSc students who want to write a good dissertation.

## Writing a good dissertation report

### Tools

Useful tools for Masters and PhD students that wants to spend their time doing research instead of mundane problems such as bibliography, crashing programs and lost data one week before the delivery(!),

#### LaTeX

Microsoft Word and its open-source siblings (WYSIWYG text processors) are good for 2 things:

  - Shopping lists (but not too long, just the groceries for 1 week)
  - Recommendation letters

Please do NOT use Microsoft Word for writing your dissertation. Makes my work hard because I need to install it, track changes, email numerous documents that drain my hard drive quota, etc.

I have heard great things about Office 365, but it still does not solve the bibliography management problems as far as I know, and keeps me, and my works, chained to a specific vendor.

Another thing I do not like about Word for research documents is that research writing is a creative process, and Word is simply not designed for creative writing. When you want to just write your thoughts as they flow, the last thing you need is 30 different buttons to remind you that you need to use styles, format with bold, italic, click click click to add a reference here and there... Just you and your text, that is all you need. And LaTeX produces beautiful documents according to actual typographic and editing standards made by people who know much more about it than me! Why fight with your editor to get something beautiful out of it? And page breaks? Give ME a break!!

#### Why LaTeX is better for scientific writing

  - Function over form
  - Absolute focus on content in detriment of formatting problems to distract you every 30 seconds
  - You can use your own text editor! Nothing like just your thoughts, your coffee mug, a fully black window and a blinking cursor.
  - Produces the most beautiful documents on this side of the universe...perhaps when I see alien documentation will change my mind
  - All plain text-based, meaning that your text is safe and not locked inside a huge binary file that can become corrupted at any second after a bad crash/recovery
  - Did I mention it is plain text-based? This means versioned documents using Git/SVN(for those stuck in the early 2000s)/Hg, etc.
  - Separation between images and text keeps assets much more manageable instead of being embedded in a huge binary. Want to reuse that great diagram in another? Say no to "Export Image as..."
  - Easy to reuse text across documents because the structure is the same, either for a short paper or a huge document with fancy structure and formatting. This is good if you want to completely change the layout of your document to try different layouts for your dissertation, with the same actual contents. Think like HTML and CSS. You take your HTML with you, and the LaTeX template is like a different CSS. Also, remember that you should not plagiarise, not even yourself! Cite accordingly.
  - Huge [number of packages](https://ctan.org) for adding fancy links, formatting, [code highlight blocks](https://ctan.org/pkg/listings), managing [acronyms](https://ctan.org/pkg/acronym) and [glossaries](https://ctan.org/pkg/glossary) appropriately (hey, did I expand the acronym the first time? hmmm need to Ctrl+F my Word document)...
  - Open-source (ok, you probably don't care about this, and frankly neither do I---it is just an added bonus)

Anyway, after this provocative text I hope the advantages of LaTeX are quite clear.

#### Overleaf

Overleaf is a great online platform for scientific writers,

#### Mendeley


#### Google Docs / GitHub Wiki / Dokuwiki /


### Structure of the document

1. Introduction
  1.1.  Context
    (Should provide a short introduction of the research domain, applications and overall interest of the problem being studied.)
  1.2.  Motivation
    (Why is the work needed? What is the perceived impact to the research/industry community to which it contributes?. This can be replaced with a section title that more closely matches the description of the problem).
  1.3.  Objectives
    (Objective tree, dividing a main, broad, high level objective into sub-objectives which can even become milestones at a later time. The objective tree helps to frame the work and can include objectives that other research or tech solutions have already achieved, the goals and subgoals to be achieved by this dissertation, and future goals that can be pursued as future work and which are outside of the scope of the dissertation). The objective tree should be represented in a tree-like diagram, which is later clearly read and explained in the text, listing every objective and its relationships with the parent and sibling objectives. The text should also clearly state which (sub) objectives are within the scope of the dissertation work and those which are outside, either because they were already achieved or because they are reserved as future work.

2. State of the art or SOTA (This is an analysis and comparison of existing approaches, models technologies and tools related to the problem domain. It should provide an overview of the latest developments in research and industry, supporting the selection of a design approach and implementation approach, technological choices, experiment design, analysis and evaluation of results)...
  2.1. An introduction to the domain(s) of study related to the problem at hand (If the work draws experience from different research domains, from the base science, theoretical approaches to architecture design and implementation, it can be interesting to provide a first section in the SOTA that helps the reader understand why the following sections are there, tying them up via a chronological and logical flow. Highlighting the evolution of the related domains of study, explaining why a certain topic is relevant to the problem and thus why it is included in the SOTA.
  2.X.  The SOTA should have as many sections as needed (around 4 to 5 is a reasonable amount). The criteria is free, but each section should approach a domain or application related to the topic in question. For example, in a serious games and gamification dissertation, it could mean the theory behind serious games, the seminal works in the area, relevant concepts, academic experiments applying the concepts, and then moving on to industrial demonstrations of the application of such theories. Evaluation methods can and should also be included in the SOTA, to highlight how related works were evaluated, draw experience from them, which can later assist in the design of our own experiment, supporting our decisions in the choices made in past works (if it worked well for solid publications, then it might work in our case too).
  2.1.1.
  2.X.X---- 2.1.x .
  2.X.N. At the end of each section, the

3. Proposed approach
  Detail how you are going to develop a

4. Implementation
  In an Informatics Engineering dissertation

5. Evaluation
  5.1 Experimental Scenario
  5.2


## General Tips

For some tips about how to carry out a successful MSc dissertation, I have compiled a list of strongly opinionated articles (read at your own peril!).

### Choosing your topic

My advice is to look at the Curricular Units that you have enjoyed the most, and get in touch with the professors that lectured you in those units. If you can find common ground for collaboration in a research context, go for it!

Also, please do not hurry to go into the industry. The final dissertation is a great opportunity for you to have a taste of a research environment and practices. It is a great way for you to do something you really like before you leave the academic environment and start your professional career. Industry is really cool too, don't get me wrong---but it is harder to do exploratory research work like you can in an academic environment. Also, you can often get a research scholarship with your Masters dissertation if it can contribute to a research project; talk with your potential supervisor to see what are the chances of that.

### Your supervisor

This is very personal, and is closely linked to the topic that you wish to follow. My only advice is to get in touch with your potential supervisors beforehand and try to get a feel for their research interests; try to see if they align with what you want to learn before the end of your course. Does this person have a good track record of supervisions? What is the opinion of the older students that were supervised by your potential supervisors? Be proactive and get in touch with everyone, do not wait until the last moment.

### Document template

Ask your supervisor if there is an established document template for the dissertation. In the case of FEUP's Masters in Informatics Engineering, the template is available at [Prof. João Correia Lopes' website](https://web.fe.up.pt/~jlopes/doku.php/teach/feupteses).

### State of the art

Anyone reading your state of the art should not succumb to "death by citation", or be "citation-machine-gunned" to death. This means that a good state of the art should not limit itself to referring the main contribution of a long list of papers. In fact, just citing a couple of sentences from a bunch of papers is worth very little.

A good course of action is to:

  1.  Identify is the research topics related to your own dissertation
  2.  Identify the main conferences and journals related to your topic (a search on ACM Digital Library, Scopus)
  4.  Search on Google Scholar for the most cited papers in those research topics, as they usually establish the base concepts of the research topic
  3.  Search on Google Scholar for papers in the last 4 years, related to that topic, to broaden your research


 Instead, try to relate what the authors say and comparing their approaches and conclusions. What do they have in common? What distinguishes them from each other?


### Evaluation

When preparing your dissertation, I believe the entire work should be driven by the design of an experiment that will enable you to prove how effective your approach is at solving the problem that you are tackling.

To design a good experiment you should establish:

1. Your *baseline*. A baseline is, so to speak, the "base of comparison" or "current state of affairs" before your work is introduced. In a research context, it is usually drawn from the state of the art.
2. Your *evaluation metric*. In order to quantify the degree of improvement introduce by your approach, you need to establish the metric through which you compare the baseline with the Is it the time a certain user takes to perform a task? How fast an al
