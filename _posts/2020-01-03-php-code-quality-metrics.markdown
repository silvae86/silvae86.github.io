---
layout: post
title:  "Static analysis of PHP code using open-source code quality tools"
date:   2020-01-03 19:23:000 +0100
categories: macos php code quality tools open source
---

While it does not replace good judgement and programming practice completely, it can be interesting to perform regular code quality analyses to make sure that you teams (and students) are writing good PHP code.

Here is a small guide on how to install them in macOS and how to use them to automatically produce metrics for all code repositories in a folder.

## Installing prerequisites

### Homebrew

First install Homebrew, the missing package manager for macOS.

{% highlight shell %}
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
{% endhighlight %}

### Install PHP using Homebrew

Here I am installing PHP 7.2, which is the same version used at FEUP servers.

{% highlight shell %}
	brew install php@7.2
{% endhighlight %}

To use this version of PHP instead of whatever you have installed in your system (5.3 on Sierra, which is very old but what I have), you need to add the following to your `~/.zshrc` file (if you use `zsh`) or `~/.bash_profile` (if you use `bash`).

{% highlight shell %}
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
{% endhighlight %}

Check your PHP version:

{% highlight shell %}
joaorocha at modo in ~
$ php --version
PHP 7.2.26 (cli) (built: Jan  3 2020 18:47:49) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.2.26, Copyright (c) 1999-2018, by Zend Technologies
{% endhighlight %}


### Install PHP Composer

{% highlight shell %}
brew install composer
{% endhighlight %}

Check your Composer version:

{% highlight shell %}
joaorocha at modo in ~
$ composer --version
Composer version 1.9.1 2019-11-01 17:20:17
{% endhighlight %}

## Installing the tools

### Detecting Copy-Pastes (duplicate code)

An interesting tool to detect copy pasted code is [PHP Copy/Paste Detector (PHPCPD)](https://github.com/sebastianbergmann/phpcpd). 

Let's install it:

{% highlight shell %}
composer global require sebastian/phpcpd
{% endhighlight %}

And run it:

{% highlight shell %}
phpcpd --fuzzy /folder/you/want/to/analyse
{% endhighlight %}



### Getting code quality metrics (Generic)

[phploc](https://github.com/sebastianbergmann/phploc) is a tool for quickly measuring the size and analyzing the structure of a PHP project.

Let's install it:

{% highlight shell %}
composer global require phploc/phploc
{% endhighlight %}

And run it:

{% highlight shell %}
phploc /path/to/your/sources
{% endhighlight %}

### Getting code quality metrics (OOP)

Another interesting open-source tool is [PHPMetrics](https://phpmetrics.org/). It produces some nice HTML reports, with support for color blind people too!

According to the [authors](https://github.com/phpmetrics/PhpMetrics/issues/379), `PhpMetrics is intended for projects with usages of packages, namespaces, classes, interfaces, and other structures like that.`. 

Let's install it:

{% highlight shell %}
composer global require 'phpmetrics/phpmetrics'
{% endhighlight %}

The composer executables may not be added to your path by default. Let's fix that by adding the following line to your `~/.zshrc` file (if you use `zsh`) or `~/.bash_profile` (if you use `bash`):

{% highlight shell %}
export PATH=$PATH:~/.composer/vendor/bin
{% endhighlight %}

And run the command:

{% highlight shell %}
phpmetrics --report-html=myreport.html /path/of/your/sources
{% endhighlight %}


## Putting it all together

Here is a script to perform all the analyses shown before, and place the results in a neat folder called `output` beside your source folders. For every folder, the script will run these utilities and produce a subfolder with the results of every single one.

Create a new file called `evaluate.sh` in the folder that contains the subfolders that you want to analyse and copy and paste the following lines.

{% highlight shell %}
#!/usr/bin/env bash

OUTPUT_DIR=$(pwd)/output

# exclude hidden directories
shopt -s dotglob

# delete existing results if they exist
if [[ -d "$OUTPUT_DIR" ]]; then
	rm -rf "$OUTPUT_DIR"
fi

# for every folder
for subfolder in */ ; do
	echo "####################################################"
	echo "Analysing $subfolder ..."
	echo "####################################################"
	SUBFOLDER_NAME=$(basename "$subfolder")
	RESULTS_SUBDIR="$OUTPUT_DIR/$SUBFOLDER_NAME"
	if [[ ! -d "$RESULTS_SUBDIR" ]]; then
		mkdir -p "$RESULTS_SUBDIR"
	fi
	
	# run phpcpd
	phpcpd --fuzzy "$subfolder" > "$RESULTS_SUBDIR/phpcpd.txt"
	
	# run phploc
	phploc "$subfolder" > "$RESULTS_SUBDIR/phploc.txt"
	
	#run phpmetrics
	phpmetrics --report-html="$RESULTS_SUBDIR/phpmetrics" "$subfolder"
done
{% endhighlight %}

To get the results, `cd` to the previously mentioned folder, and make the script executable with `chmod +x evaluate.sh` and run it using `./evaluate.sh`.

## Results

You will get something like this:

![PHP Static Analysis Results - File and folder structure](/assets/images/post-images/2020-01-03-php-code-quality-metrics/php_static_analysis_sibd.png){:class="img-center"}
