---
layout: post
title:  "How to install Jekyll using Homebrew, Mac OS X 10.14 Mojave Beta"
date:   2018-07-02 16:36:07 +0100
tags: jekyll install mac osx sysadmin mojave
redirect_from:
  - "/jekyll/install/mac/osx/sysadmin/mojave/2018/07/02/install-jekyll/"
---

This short guide shows you how to install and run a Jekyll blog in your Mac. Mojave broke some things for me in Homebrew, so this addresses some possible issues that you may also face.

## Install XCode and components

Before starting this:

Install XCode, open it and install all components it asks you to.

### Install homebrew

{% highlight shell %}
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
{% endhighlight %}

### Add binaries to path if you want

{% highlight shell %}
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc
{% endhighlight %}

### Install ruby

{% highlight shell %}
brew install ruby
{% endhighlight %}

#### (Optional) Fix homebrew links if necessary

{% highlight shell %}
sudo mkdir -p /usr/local/include
sudo mkdir -p /usr/local/lib
sudo chown -R $(whoami):admin /usr/local/include
sudo chown -R $(whoami):admin /usr/local/lib
brew list -1 | while read line; do brew unlink $line; brew link $line; done
{% endhighlight %}

### Install RVM and stable ruby

{% highlight shell %}
\curl -sSL https://get.rvm.io | bash -s stable --ruby
{% endhighlight %}

### Install Jekyll

{% highlight shell %}
sudo gem install jekyll
{% endhighlight %}

### Check Jekyll is working

{% highlight shell %}
jekyll -v
{% endhighlight %}

### cd to your blog directory

{% highlight shell %}
cd /my/blog/directory
{% endhighlight %}

### install dependencies

{% highlight shell %}
bundle install
{% endhighlight %}

### serve blog with Jekyll and Bundler

{% highlight shell %}
bundle exec jekyll serve
{% endhighlight %}
