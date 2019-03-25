---
layout: post
title:  "How to set up a basic venv for python development"
date:   2019-03-25 17:36:00 +0100
categories: python pyenv development
---

Before writing your code, you should make sure that your python environment is easily portable to other machine. None of that "Works on my machine" nonsense. 
Instead,we are going to use [venv](https://docs.python.org/3/library/venv.html), a "virtual environment" for your python development.

## Install Python (in this case, python 3.7)

This was tested in Ubuntu 16.04.

{% highlight bash %}
# install python
sudo apt-get install -y python3.7 python3.7-venv
{% endhighlight %}

## Set up `venv`

There are only a few lines that need to be uncommented:

{% highlight bash %}
# install venv
python3.7 -m venv env
# activate venv
source env/bin/activate
# install pip 
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
# upgrade pip to latest version
pip install --upgrade pip
# (optional) install any requirements of your current app in this venv
pip install -r requirements.txt 
{% endhighlight %}

Now you are ready to start coding!

{% highlight bash %}
# now we can use python instead of python3.7 as the executable name, because venv will take care of selecting the right version for us
python 
{% endhighlight %}


## Exiting `venv`

{% highlight bash %}
#simply type
deactivate
{% endhighlight %}
