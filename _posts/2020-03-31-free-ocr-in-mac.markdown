---
layout: post
title:  "OCR for PDF documents for free using macOS"
date:   2020-07-22 09:20:000 +0100
tags: macos ocr scanning homebrew
---

When you want to make a PDF searchable, there are many paid options for the Mac. However, if you are willing to use the command line, you can get some quite good results.

First, install [Homebrew](https://brew.sh) and then install [ocrmypdf](https://github.com/jbarlow83/OCRmyPDF). 

```shell
brew install ocrmypdf
```


Usage example:

![Usage example for ocrmypdf](/assets/images/post-images/2020-03-31-free-ocr-in-mac/ocrmypdf-usage.png){:class="img-center"}

This was tested in macOS Catalina (10.15.4).


### For encrypted pdfs

Sometimes the PDFs will be encrypted, and `ocrmypdf` will complain after the fact. In those cases, you can run these command to decrypt and then apply OCR to all PDFs:

```shell
find . -name "*.pdf" |  xargs -I{} qpdf --decrypt {} {}-decrypted.pdf
find . -name "*-decrypted.pdf" |  xargs -I{} ocrmypdf {} {}-ocr.pdf
````



