---
layout: post
title:  "Make your PDFs searchable using OCR for free on macOS"
date:   2020-07-22 09:20:000 +0100
tags: macos ocr scanning homebrew
---

Ever encountered a PDF from a scanned document where Ctrl+F does not work? No text selection too? 

What you need is to use OCR to make a PDF searchable! There are many paid options for the Mac, but if you are willing to use the command line... you can get some quite good and fast results using parallel processing. 

All for free!

### Requirements and basic usage

First, install [Homebrew](https://brew.sh) and then install [ocrmypdf](https://github.com/jbarlow83/OCRmyPDF). 

```shell
brew install ocrmypdf
```

Usage example:

```shell
ocrmypdf input.pdf output.pdf
```

![Usage example for ocrmypdf](/assets/images/post-images/2020-03-31-free-ocr-in-mac/ocrmypdf-usage.png){:class="img-center"}

This was tested in macOS Catalina (10.15.4).


### Advanced: handling encrypted PDFs + Deep Search

Sometimes the PDFs will be encrypted, and `ocrmypdf` will complain after the fact. In those cases, you can run these command to decrypt and then apply OCR to all PDFs in the current directory. 
	- These commands will also perform OCR on all PDFs within the current folder and its subfolders, i.e. **with deep search**:

```shell
# to delete any existing OCR'd files and redo run (if there are already semi-processed files due to errors, for example)
# -print0 + -0 in xargs -> handle files with spaces
find . -name "*-decrypted.pdf" -print0 | xargs -0 -I{} rm -f {};
find . -name "*-ocr.pdf" -print0 |  xargs -0 -I{} rm -f {};
# apply OCR in parallel (all available cores will be used - Command valid only for macos, for Linux replace sysctl -n hw.logicalcpu with nproc)
find . -name "*.pdf" -print0 |  xargs -0 -P $(sysctl -n hw.logicalcpu) -n 1 -I{} qpdf --decrypt {} {}-decrypted.pdf;
find . -name "*-decrypted.pdf" -print0 |  xargs -0 -P $(sysctl -n hw.logicalcpu) -n 1 -I{} ocrmypdf {} {}-ocr.pdf;
# remove intermediate files (decrypted pdfs)
find . -name "*-decrypted.pdf" -print0 | xargs -0 -I{} rm -f {};
````

If everything goes as planned, you will have parallel processing of OCR for your PDFs:

![Parallel processing of OCR](/assets/images/post-images/2020-03-31-free-ocr-in-mac/ocrmypdf.png){:class="img-center"}

![All cores loaded](/assets/images/post-images/2020-03-31-free-ocr-in-mac/full-load.png){:class="img-center"}


{% include info.html content="As a sidenote, I believe this uses AVX instructions, because this i9-7900X topped out at 4.0GHz on 10 cores, while the OS requested 4.5GHz. I run a negative AVX offset of -5, because even with watercooling, you can't tame this toaster." %}


### End result
And you will have proper text selection and search, even in images with captions:

![Text selection now working](/assets/images/post-images/2020-03-31-free-ocr-in-mac/ocr-working.png){:class="img-center"}


Tell me how it goes for you!