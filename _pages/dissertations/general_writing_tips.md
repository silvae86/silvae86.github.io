---
layout: page
title: Writing tips
---

# General writing tips for research papers and dissertations

Here is a short list of tips to write a good dissertation report and research paper. Some are common sense, others are solutions to common issues in LaTeX.

## Use short sentences but not too short.

A good sentence should take at least one line and at most 2 and a half line in your document. Long sentences make the reader lose track of the ideas, while short sentences seem copied and pasted.

## Avoid excessive adjectives and some informal language

> With this work, we hope to... → With this work, we will... ---- Faith in God or any other entity will not get your work published

> there has been an explosion in the growth of → There has been a significant increase in...

> huge, enormous, etc... NO!

> amazing, disruptive and similar BS adjectives ---- leave this to the Web Summit people.

> exponential growth ---- unless you have a chart to back it up, NO, it is not exponential.

> we will try to... → We will. ---- Do or do not. There is no try young Padawan.

## Do not use possessive case, negation...

> don't → do not

> isn't → is not

> researchers' opinions → opinions of the researchers

(Some exceptions can be made if you need to cram a 12-page short paper into a 4-page short paper)

## Merge multiple references

Multiple references cited in a single sentence should be merged like this:

```tex
# incorrect
~\cite{Meijer2018},~\cite{Wilkinson2016}, ~\cite{Orth2016}

# correct
~\cite{Meijer2018, Wilkinson2016,Orth2016}
```

## Images in LaTeX

An image should always have a caption, a label (for being referenced as `Figure~\ref{fig:DescritoresDCMI}` in the text), the path and a width that spans as a function of the `\textwidth`.

```tex
\begin{figure}[]
  \begin{center}
    \leavevmode
    \includegraphics[width=0.86\textwidth]{figures/DescritoresDCMI.png}
    \caption{Conjuntos de descritores Dublin Core}
    \label{fig:DescritoresDCMI}
  \end{center}
\end{figure}
```

### Do NOT use image position flags

You may see that your images are not being positioned where you want in the document. You search on StackOverflow and discover this:

``\begin{figure}[h!t!] # Force image to be placed in the h``

It may work, but after a while it will not. Do not do it, let LaTex decide for you. Really, it's better.

## Non-breaking space before citations

Use a tilde to apply a non-breaking space before the citations, so that they never stick to the word before them `~\cite{Meijer2018, Wilkinson2016,Orth2016}`

## Citations are not words

You should not use the citation as part of the sentence, ie it should be possible to read the entire sentence if the references are removed. This means that quotes must come at the end of each sentence where references are needed.

```tex
# incorrect
this is a positive step in the right direction, something that some projects such as ~\cite{Meijer2018, Wilkinson2016,Orth2016} aim to set as the norm.

# correct
this is a positive step in the right direction, something that some projects aim to set as the norm~\cite{Meijer2018, Wilkinson2016,Orth2016}.
```
