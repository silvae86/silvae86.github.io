---
layout: post
title:  "How to add your SSH keys to a server for password-less logins"
date:   2018-07-02 16:54:07 +0100
categories: sysadmin ssh keys
---

SSH keys allow you to login into your SSH server without having to remember passwords and with much stronger security. It's like having a super long password that you never have to remember... Just keep your private keys in a safe place. 

## Generate Public and Private Keys

Generate public keys. The command will produce two keys, one public (`~/.ssh/example.com-id.pub`) and one private (`~/.ssh/example.com-id`). 

{% highlight shell %}
ssh-keygen -f ~/.ssh/example.com-id
{% endhighlight %}


## Copy Public Key to the target machine

Your remote server needs to know your public key, so you need to send it there.

{% highlight shell %}
ssh-copy-id -i ~/ssh/example.com-id exampleuser@example.com #copy the public key to the target machine
{% endhighlight %}

## Set appropriate permissions

Your private key should only be visible to you and not other users, otherwise `ssh` will complain and not allow you to use the keys.

{% highlight shell %}
chmod 0700 ~/.ssh/
chmod 0600 ~/.ssh/example.com-id
{% endhighlight %}

## Create Configuration File for auto login

This config file will tell `ssh` where are the configurations for an alias for your now key-authenticated server.

{% highlight shell %}
vim ~/.ssh/config
{% endhighlight %}

### Example contents of the new file

{% highlight shell %}
Host example.com #alias of the machine into which you are logging in

HostName example.com #hostname or ip of the machine
User exampleuser #the username with which you are logging in
IdentityFile ~/.ssh/example.com-id #the private key, without "-pub"
{% endhighlight %}


### Login using machine identifier

Now you can login using `ssh` and the alias you choose in the config file above.

{% highlight shell %}
ssh example.com
{% endhighlight %}


### Save your keys and configuration file in a "safe place" for later

You can login from other computers using the same public key without having to configure the server again. 
All you need is to copy:

 - The `~/.ssh/config` file
 - The public (`~/.ssh/example.com-id.pub`) and private keys (`~/.ssh/example.com-id`)

into your `~/.ssh` directory in the new machine.

#### Fair warning!
Remember, if others also get these keys and configuration file they can log into your server!