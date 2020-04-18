---
layout: post
title:  "Using find and xargs to deep find files in a directory tree and copy them"
date:   2020-04-18 11:13:000 +0100
categories: ubuntu font install batch xargs commands cli
---

I was looking for an easy way to install a lot of fonts in Ubuntu. By the way, I discovered a great GitHub repository with many interesting ones [here](https://github.com/perrychan1/fonts)!

The issue is, when you download them you have a folder structure, and some fonts are deeper in it than others. Let's use `xargs` to find them all and put them in a single folder shall we? `xargs` is a unix command that allows you to take the results of another command (one per line) and call another command n times, one per line, injecting the line value as an argument. Pretty useful in everyday life.

The command:

```bash
find . -name "*.ttf" |  xargs -I{} cp {} ~/Desktop/fonts
```
First, we find all files with a `ttf` extension. You can repeat this for `otf`, etc. Then, we pipe the result (which is a list of paths of each font file relative to the current dir) into `xargs`, to run `cp` for each one.

The trick here is the `-I{}` flag of `xargs`. You set it up to tell `xargs` that somewhere in the command that comes after there will be an argument, and its position will be wherever the `{}` will be.

So, if we have an output like this in the result of the `find` operation:

```bash
(base) joaorocha@LenovoT420:~/Downloads/fonts-master$ find . | grep ttf
./Avenir Next/500 Medium/avenir-next-medium.ttf
./Avenir Next/700 Bold/avenir-next-bold.ttf
./Avenir Next/400 Regular/avenir-next-regular.ttf
./Avenir Next/600 Demi/avenir-next-demi.ttf
./Open Sans/OpenSans-BoldItalic.ttf
./Open Sans/OpenSans-LightItalic.ttf
```
It will be the same as running:

```bash
cp ./Avenir Next/500 Medium/avenir-next-medium.ttf ~/Desktop/fonts
cp ./Avenir Next/500 Medium/avenir-next-medium.ttf ~/Desktop/fonts
# etc...
```

After you copied all fonts into a single directory, just open Font Manager, go to the folder, press Ctrl+A and select them to install all!

![Font installer selecting all fonts](/assets/images/post-images/2020-04-18-batch-install-fonts-ubuntu/Screenshot from 2020-04-18 11:24:12.png){:class="img-responsive"}
