---
layout: keynote
title: UML Class Diagrams
permalink: /teaching/slides/uml/class/
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

.indexpill[[Associations](#associations)]

.indexpill[[Multiplicity](#multiplicity)]

.indexpill[[Generalization](#generalization)]

.indexpill[[Types of Generalization](#typesofgeneralization)]

.indexpill[[Aggregation](#aggregation)]

.indexpill[[Composition](#composition)]

.indexpill[[Self-association](#selfassociation)]

.indexpill[[Qualified association](#qualifiedassociation)]

.indexpill[[N-ary associations](#nary_associations)]

.indexpill[[N-ary association classes](#nary_association_classes)]

.indexpill[[Derived elements](#derived_elements)]

]

.index[

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

.center[.imgscaledup[![Classes](diagrams/UMLDiagrams/Classes.png)]]

.footnote[Class names are always represented in the singular, as a class denotes a **type** of entity, instead of a **set** of all entities of a certain type.]

---
name: attributes
## Attributes

- Attributes represent characteristics of all objects of the Class. They have basic types like `integer`, `double`, `string`, etc*.*

- Attributes cannot be multi-valued; if you have an attribute that can have multiple values for an object of a class, that attribute is likely a Class and should be promoted to that.

---
name: associations
## Association

- Associations are binary relationships between classes

- Represented by a line drawn between the two classes that we want to associate

.center[.imglg[![Association](diagrams/UMLDiagrams/Association.png)]]

At each end of the line we add the [multiplicity](#multiplicity) of the association*.*

---
name: multiplicity
## Multiplicity

- Serves to specify the cardinality (or possible number of elements) of some collections of elements.

- It is specified through an interval with a lower and upper bound, which can be infinite.

| Multiplicity | Equivalent | Cardinality                                         |
| ------------ | ---------- | --------------------------------------------------- |
| 0..0         | 0          | Collection must be empty (rare, but can occur)      |
| 0..1         |            | Must contain zero or one instance                   |
| 1..1         |            | Must contain exactly one instance                   |
| 0...*        | *          | Must contain zero or more instances                 |
| 1...*        |            | Must contain at least one or more instances         |
| 5...5        | 5          | Must contain exactly 5 instances                    |
| m...n        |            | Must contain at least `m` and at most `n` instances |

---
name: associationclass
## Association Class

- Sometimes we need to represent attributes derived from an association of classes instead of classes themselves

.center[.imgscaledup[![AssociationClass1](diagrams/UMLDiagrams/AssociationClass1.png)]]


- An attribute of the product? No! That would make the quantity of that product the same for every order in the system. That works if we wanted to save the **quantity in stock** of each product, for example, which only depends on the product and nothing else.


---
name: associationclassexample1
## Association Class (Example 1)

- A Class that is derived from an association between several classes
- Usually emerges to represent characteristics of the association. Groups of attributes that depend on the associated classes
- Can be derived from many-to-many relationships, one-to-one and many-to-one associations

.center[.imgscaledup[![AssociationClass2](diagrams/UMLDiagrams/AssociationClass2.png)]]

- Denoted by a box (usually without a title) connected by a dashed line to the solid line denoting the association between two classes.

---
name: associationclassexample2
## Association Class (Example 2)

.center[.imgscaledup[![AssociationClass3](diagrams/UMLDiagrams/AssociationClass3.png)]]

---
name: generalization
## Generalization

- Used to extract the common characteristics of a set of classes. A **superclass** is extracted, containing the common attributes of all **subclasses**.

- It is represented by an equilateral triangle pointing to the superclass and attached to it, with lines coming from it towards all subclasses.

.center[.imglg[![Attributes](diagrams/UMLDiagrams/Generalization.png)]]

.foonote[`Employee`s and `Customer`s are both `Person`s, so they have the attributes of a `Person`, as well as their own particular attributes]

---
name: typesofgeneralization
## Types of Generalization

- Generalizations can be 
	- **Overlapping** (an object can be of more than one subclass) or **Disjoint** (can only belong to one subclass)
	- **Partial** (objects may not belong to any of the subclasses) or **Complete** (all objects of the superclass must be also objects of one or more subclasses)

.center[.imgfull[![GeneralizationTypes](diagrams/UMLDiagrams/GeneralizationTypes.png)]]

---
name: aggregation
## Aggregation 

- A special kind of association, denoted by a line between two classes. 
- At one end we place a white diamond, which means `0...1`.
- For the other end, if nothing is written, the syntax implies `*`. We can restrict the lower bound of that multiplicity by writing something different, e.g. `1..*`.

.center[.imgscaledup[![Aggregation](diagrams/UMLDiagrams/Aggregation.png)]]

.footnote[Does **not** express parent-child relationships. If the diamond end object is deleted, the related objects still live on.]

---
name: composition
## Composition

- A special kind of Aggregation, where the diamond end denotes a `1..1` multiplicity
- If the object of at the diamond side is destroyed, so must be the related ones in the opposite end of the Composition

.center[.imglg[![Composition](diagrams/UMLDiagrams/Composition.png)]] 

- If the campus is demolished, it makes no sense to keep track of its buildings and parks anymore. 

.footnote[.red[*] A mnemonic: black = "death". "If the whole is deleted, so are all the parts".]

---
name: associationvsaggregationvscomposition
## Association vs. Aggregation vs. Composition

- Compositions are special cases of Aggregations and Aggregations are special cases of Associations.

.center[.largemargin[.imgscaledup[![AssociationVsAggregationVsComposition](diagrams/UMLDiagrams/AssociationVsAggregationVsComposition.png)]]]

---
name: selfassociation
## Self-Association

- It is also possible to specify associations between a Class and itself. 
- Useful for representing hierarchies / subcomponents (one-to-many) or graphs (many-to-many).

.center[.imgscaledup[![SelfAssociation](diagrams/UMLDiagrams/SelfAssociation.png)]]

---
name: qualifiedassociation
## Qualified association

- One or more attributes of an association used to navigate from the class with the qualifier to the other
- "Access key" from the qualifier to the qualified class

.center[.imglg[![QualifiedAssociation](diagrams/UMLDiagrams/QualifiedAssociation.png)]]

---
name: nary_associations
## N-ary associations

- n-ary associations express relationships between more than 2 classes. 
- Multiplicity is calculated one by one, by "fixating" all other classes to 1 and calculating the multiplicity of that "end" of the association according to the requirements.
- Ternary = 3 classes involved; Quaternary = 4 classes; n-ary = n classes...

.center[.imgscaledup[![NAryAssociations](diagrams/UMLDiagrams/NAryAssociations.png)]]

---
name: nary_association_classes
## N-ary association classes

- Association classes can also be associated to n-ary associations.
- Attributes need to depend on all of the associated classes!

.center[.imgscaledup[![NAryAssociationClass](diagrams/UMLDiagrams/NAryAssociationClass.png)]]

---
name: constraints
## Constraints 

- Used to specify conditions that must be met by the system
- Denoted by SQL-like text between brackets `{}`, either close to the relevant class (or classes) or connected by a dashed line to those elements

.center[.imgscaledup[![constraints](diagrams/UMLDiagrams/Constraints.png)]]

---
name: derived_elements
## Derived elements

- There can be elements (classes, attributes or associations) that are computed from others but do not actually exist.
- Notation: `/` before the name of the derived element.
- Derived elements usually have an associated constraint that relates them with other elements.
- They add complexity to the diagram, so should be used sparingly to highlight important pre-computed attributes, associations or classes

---
name: derived_attributes
## Derived Attributes 

- Can be used to highlight a frequently used element that is expensive to compute
- Indicate the need to pre-compute an attribute and save it in the system, as it will be typically read many times but written only a few
- "Caching" of results

.center[.imgscaledup[![derivedAttributes](diagrams/UMLDiagrams/DerivedAttributes.png)]]

---
name: derived_associations
## Derived Associations 

- Similar to derived attributes, but express associations that result of computation
- Expensive to compute: perform an expensive computation and save the result once on certain changes to the system (i.e. when a new `Order` is added for a `Client`, recompute the `mostPurchasedProduct` and save it). 
- Then just read the `mostPurchasedProduct` instantly many times, without having to re-compute.

.center[.imgscaledup[![derivedAssociations](diagrams/UMLDiagrams/DerivedAssociations.png)]]

---
name: derived_classes
## Derived Classes

- Classes computed from other elements in the system
- Same logic as the other derived elements

.center[.imgscaledup[![derivedClasses](diagrams/UMLDiagrams/DerivedClasses.png)]]

---
name: software
## Useful software

- For diagramming
	- [draw.io](http://draw.io) - Free online collaborative diagramming, uses Google Drive
	- [Dia](http://dia-installer.de) - Free for all Operating Systems
	- [Visual Paradigm](https://www.visual-paradigm.com) - Paid for all Operating Systems
	- [OmniGraffle](https://www.omnigroup.com/omnigraffle) - Paid for Mac

---
name: references
## References

- *Jeffrey D. Ullman and Jennifer Widom. 2008. A First Course in Database Systems. 3rd Edition*
	- Section 4.7 Unified Modeling Language

- *CS145 Lecture Notes (7) -- Higher-Level Design: UML. [Link](http://infolab.stanford.edu/~ullman/fcdb/jw-notes06/uml.html).*

{% endraw %}
{% endhighlight %}