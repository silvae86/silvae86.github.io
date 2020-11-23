---
layout: page
title: Project Information
include_in_menu: false
permalink: /teaching/2021/ESIN_SIBD/esin/project/
crumbtitle: Project
tags: teaching databases web programming feup esin 2021
---

##  Objective

The development of a small dynamic website using the technologies studied during the course.

The assignment should be done in groups of 2 elements. The constitution of these groups should be proposed by the students themselves but approved by the professor of the practical class.

The theme of the website should also be proposed by the students and approved by the professor of the practical class.

## Deliveries

### Group formation

Students are expected to divide into groups of 2 (if the class has an odd number of students, a single 3-person group will be allowed).

Students must register their groups in Moodle and validate their project topic with the professor of the practical class.

**Date**: Practical class of Week 3  

### First delivery (30% of Project component)

The first delivery will be a small report (6 pages maximum), containing:

- Description of your topic, in a similar way as you see in the exercises from the practical classes.
- UML diagram that represents the problem. The UML diagram should have at least 8 classes and cover as much of the UML language as possible (quantity &ne; quality).
- Relational model of the database. As an indication, 10-12 tables is a healthy count.

The document must be a single PDF file, submitted via [Moodle](https://moodle.up.pt). In the cover page students must write:

- Name of the topic		
- Full name of all members of the group and institutional emails
- Number of their practical class

To avoid duplicate emails, [here is a list of answers](/teaching/2021/ESIN_SIBD/faq_topic_choice/) to previous questions about the work topic. You may find an answer to your question here, before sending email to the course professors.

**Delivery date**: 20th November 2020 at 23:59

### Second delivery (70% of Project component)

The second delivery will be a [GitHub](https://github.com) repository containing the website itself. When the work is finished, add the users [zeornelas](https://github.com/zeornelas) and [silvae86](https://github.com/silvae86) to the list of collaborators of the repository. After adding us as collaborators, clone your repository using `git clone`, zip the resulting folder and upload it [Moodle](https://moodle.up.pt). **Both steps are required**.

**Expected contents**

- SQL script to create the database.
- All PHP, CSS, images and other files.
- A README file in the root folder containing data about the authors and how to install and run the project. 
  - *Ideally, professors should only need to clone the repository and [run the docker boot up command](/teaching/2021/ESIN_SIBD/project_setup) on the cloned folder to boot up the website. Test this before submitting.*
- No frameworks or external libraries are allowed (jQuery, Bootstrap, Angular, CSS pasted from StackOverflow etc...). You must write **everything from scratch**, and any unlawful behaviour will be strongly punished.

**Delivery date**: 23rd December 2020 at 23:59

**Presentation**: In the last practical class of the semester.

**Format of presentation**: The presentation will be carried out by the students and to the teachers of the practical classes. No slides are required, and only the working website should be presented.

#### Setting up the project environment

[Project setup tutorial](/teaching/2021/ESIN_SIBD/project_setup)

#### Project planning

![How to succeed in the practical work](../../common/project_management.png){:class="img-center"}

#### Final checklist

Here are some last minute checks to do before sending in your work.

- Did you run your whole script on a blank database? does it run without errors?
- Did you validate your HTML and CSS?
- Do all your web pages render correctly in the browser, without 404 errors (use the browser inspector for this)
- Does your ZIP file actually contain everything that is expected?

### Penalty for delays

When students do not deliver their work within the deadline, the whole group will receive a penalty of 20% **per day of delay**. Example: if you deliver a work 2 days late, your grade for that delivery will be multiplied by 60% and the result will be your final grade.

Deliveries submitted 5 or more days after the deadline will not be considered and the group in question will receive a classification of zero.

Important: Imagine something is missing from your submission package or report. If you submit a new version at a later time you will be penalized for delay over the entire work as if you had only submitted at the moment of the second submission. **Check and double-check your submissions to avoid undesirable situations**.

## Words of advice / FAQ

Here is some advice and answers to common questions. For successful and fun experience during the course, read these carefully.

### Do the database right, before moving to code

Without the proper foundation (a correct database schema) any code you write on top will not work properly. Finish and validate your database schema with your practical class professor before starting to code.

### Planning ahead

It is a good idea to work *smart* instead of *hard*. Split your problem into smaller ones, prioritize those, and add more features as time allows. Basic functionality like a list in a homepage or the login should **not** fail on the day of the demo, especially if you spent time implementing other "optional" features.

In the professional world, all client requirements are broken down into smaller features that must be prioritized, their effort estimated, and some even need to be dropped. What seems very interesting / essential today may not seem like a good idea two weeks from now, and may be dropped algether.

### Keep it simple

Make the CSS simpler but cleaner (write less code and validate it as you go). If the website has so many issues that I cannot navigate it easily or even find all the features you implemented... your grade will suffer. Simple and working is always better than complex and buggy.

### Learn to use Git

[Git](https://web.fe.up.pt/~arestivo/presentation/git/#1) is a great way to keep track of code modifications within your team and merge changes into a clean, organized codebase. No more emailing ZIP files between your colleagues and copying and pasting the changes by hand!

GitHub is a safe place to put your code while you are writing it, just make sure to create a private repository. They provide free Pro accounts for students and educators, so I think you should register [here](https://education.github.com/students).

BitBucket is also a great free alternative, with similar [benefits](https://bitbucket.org/product/education) for students and educators. Atlassian, the creators of BitBucket, provide a very nice and free GUI program, [SourceTree](https://www.sourcetreeapp.com), for working with any Git repository (not just BitBucket) if you do not wish to use the git command line.

Note: I am not in any way affiliated with these solutions nor do I get any benefit for promoting them. You are free to use them or not.

### Avoid caffeine

Please do not wait until the last week to work seriously on the project. Coding (especially CSS) is not something you want to in all-nighter.

### Unequal sharing of work

If something is not going well in a project group, I need to know as soon as possible, and I trust you to tell me of any anomalies. I will not enquire about this, and in the absence of any complaints, I will assume everything is OK with the work group.

I will **not** accept complaints about this after the grades are published.

### Last-minute emails

Do not wait until the last weekend before the delivery of the work to start emailing me questions about it. I have a personal life too and you may not get an answer in time.


Good luck!
