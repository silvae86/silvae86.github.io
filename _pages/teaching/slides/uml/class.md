---
layout: keynote
title: Keynote on UML - Unified Modelling Language
permalink: /teaching/slides/uml/uml1/
---
{% highlight text %}
{% raw %}
name: uml
class: middle, center
template:inverse

# UML 
[Unified Modelling Language] 

## Class Diagrams
by [João Rocha da Silva](https://silvae86.github.io), based on the [book](https://dl.acm.org/citation.cfm?id=1554749) by Ullman and Widom.

---
name: agenda
class: middle, center

## Agenda
.index[

.indexpill[[Purpose](#purpose)]

.indexpill[[Classes](#classes)]

.indexpill[[Attributes](#attributes)]

.indexpill[[Attributes](#attributes)]

.indexpill[[Associations](#associations)]

.indexpill[[Multiplicity](#multiplicity)]

.indexpill[[Generalization](#generalization)]

.indexpill[[Aggregation](#aggregation)]

.indexpill[[Composition](#composition)]

.indexpill[[Self-association](#selfassociation)]

.indexpill[[N-ary associations](#nary_associations)]
]

.index[

.indexpill[[Example: Car showroom](#example)]

.indexpill[[Useful software](#software)]

.indexpill[[References](#references)]

]
---
name: purpose
## Purpose

- To represent the data model of an information system

- Programmers and system designers alike can understand

- Often derived from the reality of a system as described by the client (usually in text)

- Can later be converted into a relational schema

.footnote[These slides will use the example of a furniture manufacturing company to illustrate the syntax of UML class diagrams.]

---
name: classes
## Classes

Classes are used to represent the main entities of the system. 

Their syntax consists of a box with two main sections.

- The first section contains the **name** of the class 
- The bottom will contain all the Class's [Attributes](#attributes), **one per line**.

.center[.imglg[![Attributes](../diagrams/UMLDiagrams/Classes.png)]]

.footnote[Class names are always represented in the singular, as a class denotes a **type** of entity, instead of a **set** of all entities of a certain type.]

---
name: Attributes
## Attributes

- Attributes represent characteristics of all objects of the Class. They have basic types like `integer`, `double`, `string`, etc.

- Attributes cannot be multi-valued; if you have an attribute that can have multiple values for an object of a class, that attribute is likely a Class and should be promoted to that.

---
name: generalization
## Generalization

- Used to extract the common characteristics of a set of classes. A **superclass** is extracted, containing the common attributes of all **subclasses**.

- It is represented by an equilateral triangle pointing to the superclass and attached to it, with lines coming from it towards all subclasses.

.center[.imgfull[![Attributes](../diagrams/UMLDiagrams/Generalization.png)]]

.foonote[`Employee`s and `Customer`s are both `Person`s, so they have the attributes of a `Person`, as well as their own particular attributes]

---
name: associations
## Associations

- Associations are binary relationships between classes

- Represented by a line drawn between the two classses that we want to associate

.center[.imglg[![Association](../diagrams/UMLDiagrams/Association.png)]]

At each end of the line we add the [multiplicity](#multiplicity) of the association.

---
name: multiplicity
## Multiplicity



---
name: aggregation
## Aggregation

---
name: composition
## Composition

---
name: selfassociation
## Self-Association

---
name: nary
## N-Ary associations

---
name: nary_associations
## N-Ary associations

---
name: attributeorclass
## Attribute or Class? 

It is not possible to establish 

---
name: example
## Example: Car showroom

---
name: software
## Useful software

---
name: references
## References

{% endraw %}
{% endhighlight %}