---
layout: post
title:  "Getting Python to install and run on M1 Pro MacBook Pro with macOS Monterey"
date: 2022-04-13 20:10:000 +0100
tags: macintosh python pyenv apple silicon monterey
published: true
comments_id: 38
---

In order to get [Bash Beautify](https://marketplace.visualstudio.com/items?itemName=shakram02.bash-beautify) working on my Mac, I had to have both the `python2` and `python3` commands running on my Mac. 

After installing pyenv via homebrew:

```bash
brew install pyenv
```

I tried to set my Python versions:

```bash
$ pyenv global 3.7.0 2.7.15
pyenv: version `3.7.0' not installed
```

Running the installation command produced the following error:

```bash
$ pyenv install 3.7.0       
python-build: use openssl@1.1 from homebrew
python-build: use readline from homebrew
Downloading Python-3.7.0.tar.xz...
-> https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
Installing Python-3.7.0...
python-build: use readline from homebrew
python-build: use zlib from xcode sdk

BUILD FAILED (OS X 12.3.1 using python-build 20180424)

Inspect or clean up the working tree at /var/folders/d1/k0pk6j150dd7xw7qh55n_0bc0000gn/T/python-build.XXXXXXXXX
Results logged to /var/folders/d1/k0pk6j150dd7xw7qh55n_0bc0000gn/T/python-build.XXXXXXXXXX.log

Last 10 log lines:
checking for --with-cxx-main=<compiler>... no
checking for clang++... no
configure:

  By default, distutils will build C++ extension modules with "clang++".
  If this is not intended, then set CXX on the configure command line.
  
checking for the platform triplet based on compiler characteristics... darwin
configure: error: internal configure error for the platform triplet, please file a bug report
make: *** No targets specified and no makefile found.  Stop.
```

To fix it, I first selected the version I wanted to install with `pyenv install --list`. Then, I installed GCC from homebrew, and tried installing again, this time specifying the path to the C++ compiler. 

I the following script, replace `gcc-12` with a newer version if necessary. Type `cd /opt/homebrew/bin/gcc<Press Tab key>` in the Terminal and see what version you have installed.

````bash
brew install gcc
CC=/opt/homebrew/bin/gcc-12 pyenv install 3.8.12 
CC=/opt/homebrew/bin/gcc-12 pyenv install 2.7.18
````

### Note for macOS Ventura Beta!

When running `xcode-select --install` you may face this error:

````
Can't install the software because it is not
currently available from the Software
Update server
````

To fix it, download command line tools from Apple's [More Downloads](https://developer.apple.com/download/all/) page on Apple Developer before running `brew install gcc`.


I then set them as the default python versions globally:

```bash
pyenv global 3.9.12 2.7.18
```

Done! Bash Beautify works in Visual Studio Code now.

