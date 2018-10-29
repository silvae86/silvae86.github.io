---
layout: page
title: Supervision
include_in_menu: true
---

I have supervised several MSc dissertations at FEUP, both in Information Science and Informatics Engineering. Based on these, I have compiled several guidelines for new MSc students who want to write a good dissertation.

## Writing a good dissertation report

### Tools

Useful tools for Masters and PhD students that wants to spend their time doing research instead of mundane problems such as bibliography organization, crashing programs and lost data one week before the delivery(!), and others.

#### LaTeX

Microsoft Word and its open-source siblings (WYSIWYG text processors) are good for 2 things:

  - Shopping lists (but not too long, just the groceries for 1 week)
  - Recommendation letters

Please do NOT use Microsoft Word for writing your dissertation. Makes my work hard because I need to install it, track changes, email numerous documents that drain my hard drive quota, etc.

I have heard great things about Office 365, but it still does not solve the bibliography management problems as far as I know, and keeps me, and my works, chained to a specific vendor.

Another thing I do not like about Word for research documents is that research writing is a creative process, and Word is simply not designed for creative writing. When you want to just write your thoughts as they flow, the last thing you need is 30 different buttons to remind you that you need to use styles, format with bold, italic, click click click to add a reference here and there... Just you and your text, that is all you need. And LaTeX produces beautiful documents according to actual typographic and editing standards made by people who know much more about it than me! Why fight with your editor to get something beautiful out of it? And page breaks? Give ME a break!

If you want to read more about why I think LaTeX is the best choice for scientific writing, read [this opinion post](/latex/scientific/writing/tools/2018/10/28/why-latex-is-the-best-for-scientific-writing).

#### Overleaf

[Overleaf](https://www.overleaf.com/) is a great online platform for scientific writers. It is basically a collaborative text editor with syntax highlighting for TeX and an automatic compilation feature that allows you to see the changes made to your document as you type. It is as close to a WYSIWYG experience for LaTeX writing as you can get on the web.

#### Mendeley

[Mendeley](https://www.mendeley.com/download-desktop/) is a reference manager that allows you to easily store all your references. It provides 3 main capabilities (in my opinion):

1. **Cloud Synchronization**. If you work across several computers, Mendeley will sync your references database across them all, and you are not
2. **"Automatic" bibliographic record fetching**. You can drag and drop the PDFs of your papers to the Mendeley app and it will try to automatically fetch the bibliographic record and fill in the bibliographic entry for you. It does not always work, though, so you need to keep an eye on the right sidebar of mendeley to check for wrong records.
3. **Note-taking and highlighting**. You can take notes and highlight interesting parts of your PDFs directly in Mendeley. I do not recommend making all your highlighting in the app and instead use your favorite PDF editor (such as the Mac Preview). Why you ask? Because if you copy the PDF from your Mendeley Library into a pendrive, for example, the notes are not actually saved in the PDF but in Mendeley servers and overlaid over the PDF when you use the Mendeley app. If you do not want to keep your notes chained to Mendeley, use right-click -> "Open File Externally..." to launch the PDF reader, edit what you want and when you are finished Mendeley will sync the updated PDF to the cloud.

#### Note-taking apps

Throughout your dissertation you will most certainly produce a lot of records of your research activity: reading sheets, experiment results, personal thoughts, etc.

To store these, you can use something so simple as Google Docs or Google Keep for flat notes, or a Wiki such as GitHub Wiki or a Dokuwiki. I also added Mendeley here because while it is not a full-fledged wiki, it can be used to keep track of reading notes attached to your references. The free-text search of Mendeley will also index your notes, making it possible to find the reference you want by something you have written in your notes.

![Mendeley Notes](/assets/images/supervision/mendeley_notes.png){:class="img-center"}

*Notes in the Mendeley interface*{:class="img-caption"}


|             | Search | Looks  | Structure | Installation | Dependencies | Syntax        |
|-------------|--------|--------|-----------|--------------|--------------|---------------|
| Google Keep | *****  | ***    | *         | *****        | *****        | No Syntax     |
| Google Docs | **     | ****   | *         | *****        | *****        | WYSIWYG       |
| Dokuwiki    | *****  | ****   | *****     | ***          | **           | Dokuwiki      |
| Github Wiki | ****   | *****  | ***       | ****         | *****        | Markdown      |
| Mendeley    | *****  | *      | *         | *****        | **           | WYSIWYG (?)   |

**Search**. It should be possible to retrieve your notes quickly with a search feature. In this case, Google Keep and Dokuwiki offer a fast querying interface to quickly find what you need. Google Docs buries the text in different documents, making it confusing to fetch what you need with a simple Ctrl+F.

**Looks**. The overall aspect of your notes, as you make them. This is subjective, of course. In my opinion, the GitHub wiki is the best-looking of the bunch, with its online interface.

**Structure**.

#### Cloud storage

You can use external hard drives to store your dissertation and all related materials, but those can die at the worst possible moments. Use Google Drive, Dropbox, or any other cloud storage solution to keep regular backups. If you are afraid that someone can steal your work if your cloud provider gets hacked, just compress the stuff into a ZIP, 7z or RAR archive, and encrypt it with a strong key before you upload it to the cloud.

### Structure of the document

1. **Introduction**
    1. **Context**
      Should provide a short introduction of the research domain, applications and overall interest of the problem being studied.
    2. **Motivation**
      (Why is the work needed? What is the perceived impact to the research/industry community to which it contributes?. This can be replaced with a section title that more closely matches the description of the problem).
    3. **Objectives**
      (Objective tree, dividing a main, broad, high level objective into sub-objectives which can even become milestones at a later time. The objective tree helps to frame the work and can include objectives that other research or tech solutions have already achieved, the goals and subgoals to be achieved by this dissertation, and future goals that can be pursued as future work and which are outside of the scope of the dissertation). The objective tree should be represented in a tree-like diagram, which is later clearly read and explained in the text, listing every objective and its relationships with the parent and sibling objectives. The text should also clearly state which (sub) objectives are within the scope of the dissertation work and those which are outside, either because they were already achieved or because they are reserved as future work.

2. **State of the art or SOTA**
    This is an analysis and comparison of existing approaches, models technologies and tools related to the problem domain. It should provide an overview of the latest developments in research and industry, supporting the selection of a design approach and implementation approach, technological choices, experiment design, analysis and evaluation of results)...
    1. An introduction to the domain(s) of study related to the problem at hand (If the work draws experience from different research domains, from the base science, theoretical approaches to architecture design and implementation, it can be interesting to provide a first section in the SOTA that helps the reader understand why the following sections are there, tying them up via a chronological and logical flow. Highlighting the evolution of the related domains of study, explaining why a certain topic is relevant to the problem and thus why it is included in the SOTA.
    2.  The SOTA should have as many sections as needed (around 4 to 5 is a reasonable amount). The criteria is free, but each section should approach a domain or application related to the topic in question. For example, in a serious games and gamification dissertation, it could mean the theory behind serious games, the seminal works in the area, relevant concepts, academic experiments applying the concepts, and then moving on to industrial demonstrations of the application of such theories. Evaluation methods can and should also be included in the SOTA, to highlight how related works were evaluated, draw experience from them, which can later assist in the design of our own experiment, supporting our decisions in the choices made in past works (if it worked well for solid publications, then it might work in our case too). At the end of each section, the

3. Proposed approach
  Detail how you are going to develop a

4. Implementation
  In an Informatics Engineering MSc dissertation, it is common to have to implement a prototype of some sort, in order to build a testbed for your approach. This can be an addition to an existing software solution---in which the technological stack will already be pre-defined---or a completely new piece of software, for which you will have to select the most appropriate technologies at every level of the tech stack.

5. Evaluation
  1. Experiment configuration
  2. Results analysis
  3. Conclusions and discussion

## General Tips

For some tips about how to carry out a successful MSc dissertation, I have compiled a list of opinionated articles (read at your own peril!).

### Choosing your topic

My advice is to look at the Curricular Units that you have enjoyed the most, and get in touch with the professors that lectured you in those units. If you can find common ground for collaboration in a research context, go for it!

Also, please do not hurry to go into the industry. The final dissertation is a great opportunity for you to have a taste of a research environment and practices. It is a great way for you to do something you really like before you leave the academic environment and start your professional career. Industry is really cool too, don't get me wrong---but it is harder to do exploratory research work like you can in an academic environment. Also, you can often get a research scholarship with your Masters dissertation if it can contribute to a research project; talk with your potential supervisor to see what are the chances of that.

### The supervisor

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
