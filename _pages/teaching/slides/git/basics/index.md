---
layout: keynote
title: Git Basics
permalink: /teaching/slides/git/basics/
---
{% highlight text %}
{% raw %}
name: git
class: middle, center
template:inverse

# Git 
[distributed version-control system] 

## Basics of Git
by [João Rocha da Silva](https://silvae86.github.io), based on ['Version Control with Git, 2nd Edition'](https://www.oreilly.com/library/view/version-control-with/9781449345037/) by Jon Loeliger & Matthew McCullough.

---
name: agenda
class: middle, center

## Agenda
.index[

.indexpill[[About](#about)]

.indexpill[[History](#history)]

.indexpill[[Concepts](#concepts)]

.indexpill[[Creating a repository](#creating)]

.indexpill[[Cloning a repository](#clone)]

.indexpill[[Adding files](#adding)]

.indexpill[[Checking status](#status)]

.indexpill[[Committing](#committing)]

.indexpill[[Pushing your commits](#pushing)]

.indexpill[[Pulling changes](#pulling)]

.indexpill[[Branches](#branches)]

.indexpill[[Merging](#merging)]

.indexpill[[Conflicts](#conflicts)]

.indexpill[[Tracking history](#log)]

]

.index[

.indexpill[[GitHub](#github)]

.indexpill[[References](#references)]

]
---
name: about
## About

- A *distributed* source code *version control* system. 

- *Version control* because it tracks all changes made to the code of a software solution

- *Distributed*, because it does not require a *repository server*
	- All collaborators of the repository can synchronise their code without the need for a central authority

.footnote[We will only cover some basics of Git usage in these slides.]

---
name: history
## History

Classes are used to represent the main entities of the system. 

Their syntax consists of a box with two main sections.

- The first section contains the **name** of the class 
- The bottom will contain all the Class's [Attributes](#attributes), **one per line**. 

.center[.imgscaledup[![Classes](diagrams/UMLDiagrams/Classes.svg)]]

.footnote[Class names are always represented in the singular, as a class denotes a **type** of entity, instead of a **set** of all entities of a certain type.]

---
name: references
## References

- *Jeffrey D. Ullman and Jennifer Widom. 2008. A First Course in Database Systems. 3rd Edition*
	- Section 4.7 Unified Modeling Language

- *Git Commands on GitHub, by joshnh* [Link](https://github.com/joshnh/Git-Commands)
	- An interesting *cheat sheet* for command-line (advanced) use of Git

{% endraw %}
{% endhighlight %}