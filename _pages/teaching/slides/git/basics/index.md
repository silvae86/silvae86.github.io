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

## Introduction and Basics
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

- A **distributed** source code **version control** system.

- **Version control** because it tracks all changes made to the code of a software solution

- **Distributed**, because it does not require a **repository server**
	- All collaborators of the repository can synchronize their code without the need for a "central authority"
- <u>Keeps your code safe, </u>

.footnote[.red[*]We will cover some basics of Git usage in these slides. More advanced usage can be explored in the bibliography]

---
name: history
## History


| Year | Name                      | Acronym | Type          |
| ---- | ------------------------- | ------- | ------------- |
| 1986 | Concurrent Version System | CVS     | Centralized   |
| 2001 | Subversion                | SVN     | Centralized   |
| 2000 | BitKeeper                 | -       | Decentralized |
| 2005 | Mercurial                 | Hg      | Decentralized |
| 2005 | Git                       | -       | Decentralized |
|      |                           |         |               |

---
name: references
## References

- *Version Control with Git, 2nd Edition* 
	Loeliger, J., & McCullough, M. (2012).  
	O'Reilly Media, Inc..

- *Git Commands on GitHub, by joshnh* [Link](https://github.com/joshnh/Git-Commands)
	- An interesting *cheat sheet* for command-line (advanced) use of Git

{% endraw %}
{% endhighlight %}
