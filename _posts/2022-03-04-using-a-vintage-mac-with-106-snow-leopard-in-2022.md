---
layout: post
title:  "Using a vintage Mac with 10.6 Snow Leopard in 2022"
date: 2022-03-07 18:10:000 +0100
tags: vintage computing mac osx macbook pro snow leopard afp mount
published: true
inconstruction: true
---

Here is a little bit of my personal history using Macintosh computers, combined with a short guide on how to use [AFP (Apple Filing Protocol)](https://en.wikipedia.org/wiki/Apple_Filing_Protocol) shares to offload heavy compilation operations to a more modern and powerful machine, while using a vintage Mac for simple text editing and browsing compiled result. I am using the [source code of this very blog](http://github.com/silvae86/silvae86.github.io) as a test case. 

## My history with Macs

I made my switch to the Mac around 2008, while I was still an MSc. student of Informatics Engineering. First, I started by trying to convert my PC into a Hackintosh running 10.5 Leopard. It was a terrible choice of hardware, since only Intel could run reliably back then. 

{:.float-img-right}
![Work setup at home, circa 2009](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/workroom.jpg)<br>*Home setup, circa 2009. At the bottom left, my first Hackintosh running on an AMD64 3000+ CPU. Under the table below the printer, a Linux server cobbled together from old parts.*

Kernel panics were frequent, but it was all worth it when it finally booted up. The shadows looked amazing, and using [Adium](http://adium.im), the native Mac cross-platform messaging app for the first time is an experience that I will not forget. I had no money to actually buy a Mac, but one that was sure that one day I would own my very own Mac laptop. I figure that I would give up on the ability to play some games in exchange for a superior work machine.

In 2009 my parents got me my first Mac laptop at a great discount, when the Unibody ones started coming in. It was an [Early 2008 MacBook Pro A1260](https://everymac.com/systems/apple/macbook_pro/specs/macbook-pro-core-2-duo-2.4-15-early-2008-penryn-specs.html) model that came with 10.5 Leopard, and I absolutely loved it. By this time, Windows XP ruled the classrooms, and a glowing Apple logo on the back of a computer lid was a rare sight in Portuguese university classrooms---at least outside of a Fine Arts class, where Macs were greatly praised for their tight integration with the Adobe create suite. 

Most students like myself were using Windows XP as their main OS (after all, we were students and needed to play games) and Linux was the OS of choice for those subjects where UNIX was required. On PCs of the time it was common to have to dim the screen to the minimum and cut down CPU clock using [RMClock](https://cpu.rightmark.org/products/rmclock.shtml) if you wanted it to last throughout a 2 hour class. The battery life of the Mac was amazing by comparison. It would get 4 hours in class with 25% brightness, so I could actually see what I was typing. The Mac also gave me a window into a UNIX-based system that I could actually daily drive, because GUI apps worked great, and BASh scripting was readily available out of the box. 

{:.float-img-left}
![Me working on my MSc. Dissertation](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/msc.jpg) <br> *That's me working on my MSc. dissertation, circa 2009. <br> Notice the A1260 MacBook Pro and the [Motorola V3X](https://www.gsmarena.com/motorola_v3x-1120.php) on the table*

I hold dear memories of using that computer, since it was my main work tool throughout an [MSc. dissertation](https://hdl.handle.net/10216/58508), starting a [YouTube channel](https://www.youtube.com/user/MoleskineFan?app=desktop), and the early stages of what ended up becoming my [Ph.D. thesis](https://hdl.handle.net/10216/83993). [Omnigraffle Pro 5](https://www.omnigroup.com/download) was awesome to design UML Class diagrams in! Unlike [Microsoft Visio](https://www.microsoft.com/en-us/microsoft-365/previous-versions/microsoft-visio-2007) on Windows or [Dia](http://dia-installer.de/) on Linux, it had nice and smooth shadows, anti-aliased fonts and overall better look. Like in food, the eyes also eat.

Overall, the typography on a Mac looked better. The keyboard was smooth, the monitor colorful and vibrant. The OS was truly **fun** to use, even more so than Windows XP. The subtle, pulsing glow of the default button in a modal window in Snow Leopard...I have to admit, I love the skeuomorphic design from those days! And while some may consider Windows XP childish and plasticky, I loved its simplicity and intuitive colors back then. I still do!

I had no idea how spoiled I was at that time. Since Yosemite (10.10) every control in the Mac Operating Systems is flat and streamlined, in the name of clean-cut functionality.

## Living the OS X dream. Again.

Like many of its kind, my 2008 Macbook Pro died a painful death when its GPU, the [flawed nVidia 8600GT](https://forums.macrumors.com/threads/so-are-all-mbp-owners-with-the-8600m-gt-cards-screwed.515067/), finally gave up on me around 2012. 

{:.float-img-left}
![My 2010 Unibody Plastic White MacBook](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/2010_macbook_unibody_white.jpg)<br>*2010 Unibody Macbook White (plastic).*

Meet my 2010 MacBook Unibody White with an Intel 2.4 GHz Core 2 Duo processor. I bought this laptop right after my 2008 MacBook died. It was a beaten up machine that I got second hand for a cheap price. It came with a 1000-plus cycle count battery, was missing a couple of keys in the keyboard and used an aftermarket power adapter lighter than a single egg. But hey, when you are a Ph.D. student you can't be picky, and it was nothing I could not fix! I then upgraded it as much as I could, with a new aftermarket battery (still lasts 4-5 hours in light use to this day), a 250 GB Samsung 840 SSD, 8GB RAM, and the missing keyboard keys.

The thing about this laptop is that you can run many versions of Mac OS X, from Snow Leopard (10.6) up to Catalina (10.15) through the [unofficial patcher](https://github.com/dosdude1/macos-catalina-patcher) by dosdude1. 

{:.floatquote}
We made the buttons on the screen look so good you'll want to lick them.<br><br>Steve Jobs (Co-founder at Apple)

## Using AFP mounts to compile this blog remotely

Because I like to use completely outdated/unsafe but absolutely beautiful operating systems to write my blog posts, I set out to find a way to use my MacBook as a text editing and music playing machine, so I can use the old TextMate 1.5 and Omnigraffle 5 Pro. At the same time, I can use a much more recent and more powerful computer to compile the sources of this blog.

It's easy to use a flash drive to transfer an entire project between machines and compile it in the more recent one. It is also easy to use Screen Sharing to work remotely on the more modern machine. Instead of using these methods, will use AFP shares to mount the folder in the vintage Mac on the modern machine. We then start the server that automatically compiles Then, whenever a file is saved on the folder of the vintage machine, 

## Some awesome applications with support for vintage Macs

- [Max - Audio Converter & CD Ripper](https://sbooth.org/Max)










 






