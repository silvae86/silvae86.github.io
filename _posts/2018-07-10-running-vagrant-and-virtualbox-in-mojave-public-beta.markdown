---
layout: post
title:  "Fixing Virtualbox and Vagrant in macOS Mojave 10.14 Public Beta 3"
date:   2018-07-10 15:34:00 +0100
categories: sysadmin mojave beta vagrant virtualbox osx macos
---

The new beta of Mac OS X Mojave is mostly stable and so far it has been a good experience... Apart from the [recent issues that i have faced](/sysadmin/mac/osx/mojave/beta/libxml2/2018/07/05/fixing-missing-headers-for-homebrew-in-mac-osx-mojave.html) with homebrew legacy libraries and this recent problem with Virtualbox, which loads a Kernel Extension that has not yet been approved by Apple.

Here is a **temporary solution** to get you up and running with the latest Mac OS beta.

## Download a build later than 5.2.12 of Virtualbox 5

Go [here](https://www.virtualbox.org/wiki/Testbuilds) and download the Virtualbox Development Snapshot version. [Direct link](https://www.virtualbox.org/download/testcase/VirtualBox-5.2.97-123220-OSX.dmg) for the one I got (5.2.97 at this time).


## Disable System Integrity Protection (SIP)

Yes, yes, I also hate this, but has to be done until Apple refreshes the list of allowed Kernel Extensions to allow `VBoxDrv.kext` to load properly in Mojave.

1. Reboot your Mac and hold Command + R (⌘ + R) before it boots. 
2. Keep holding it until you see the progress bar 
3. Wait for it to finish
4. At the top menu, select Utilities -> Terminal
5. Enter `csrutil disable`
6. Press Enter
7. Type `reboot`

After this is solved, do the same steps to re-enable SIP, but type `csrutil enable` at Step 5.

## (Try to) Install Virtualbox

Run the installer. 

![Installer Running](/assets/images/post-images/2018-07-10-running-vagrant-and-virtualbox-in-mojave-public-beta/Screenshot 2018-07-10 at 15.22.49.png){:class="img-responsive"}


You will get an error message like this:

![Installer Error](/assets/images/post-images/2018-07-10-running-vagrant-and-virtualbox-in-mojave-public-beta/Screenshot 2018-07-10 at 15.22.51.png){:class="img-responsive"}

No worries, close it and continue.

## Modify Kexts, rebuild Kernel Extension Cache

{% highlight shell %}
#Fix Kernel Version

sudo sed -i '' 's/5\.2/5\.3/g' '/Library/Application Support/VirtualBox/VBoxDrv.kext/Contents/Info.plist'
sudo sed -i '' 's/5\.2/5\.3/g' '/Library/Application Support/VirtualBox/VBoxUSB.kext/Contents/Info.plist'
sudo sed -i '' 's/5\.2/5\.3/g' '/Library/Application Support/VirtualBox/VBoxNetAdp.kext/Contents/Info.plist'
sudo sed -i '' 's/5\.2/5\.3/g' '/Library/Application Support/VirtualBox/VBoxNetFlt.kext/Contents/Info.plist'

#Load Kernel Extensions

sudo kextload '/Library/Application Support/VirtualBox/VBoxDrv.kext'
sudo kextload -d '/Library/Application Support/VirtualBox/VBoxDrv.kext' '/Library/Application Support/VirtualBox/VBoxUSB.kext'
sudo kextload -d '/Library/Application Support/VirtualBox/VBoxDrv.kext' '/Library/Application Support/VirtualBox/VBoxNetFlt.kext'
sudo kextload -d '/Library/Application Support/VirtualBox/VBoxDrv.kext' '/Library/Application Support/VirtualBox/VBoxNetAdp.kext'

#Rebuild Kernel Extensions Cache
sudo kextcache -i /

# Start up Virtualbox GUI
Virtualbox &

{% endhighlight %}

[Credit @IPV6Freely](https://forums.virtualbox.org/viewtopic.php?f=39&t=88231&start=75)

## Starting Virtualbox

Using the GUI will give you an error:

![GUI Error](/assets/images/post-images/2018-07-10-running-vagrant-and-virtualbox-in-mojave-public-beta/Screenshot 2018-07-10 at 16.52.06.png){:class="img-responsive"}

However, you should be able to start VirtualBox using the Terminal:

{% highlight shell %}
Virtualbox &
{% endhighlight %}

## Fix plugin installations if you are using Vagrant and they fail to install

Before I had this, which worked before Mojave and in Linux too:

{% highlight ruby %}

required_plugins = %w(vagrant-share vagrant-vbguest vagrant-disksize vagrant-proxyconf)
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
{% endhighlight %}

This caused issues:

{% highlight shell %}
Exec error: fork/exec /opt/vagrant/embedded/bin/ruby: argument list too long 
Exec error: fork/exec /opt/vagrant/embedded/bin/ruby: argument list too long 
Exec error: fork/exec /opt/vagrant/embedded/bin/ruby: argument list too long
{% endhighlight %}

The solution was to reformulate the plugin installation code in the `Vagrantfile` like this:

{% highlight ruby %}

required_plugins = %w(vagrant-share vagrant-vbguest vagrant-disksize vagrant-proxyconf)
return if !Vagrant.plugins_enabled?

plugins_to_install = required_plugins.select { |plugin| !Vagrant.has_plugin? plugin }

if plugins_to_install.any?
  system "vagrant plugin install #{plugins_to_install.join(' ')}"
  exit system 'vagrant up'
{% endhighlight %}

[Credit to @nuxy for this fix](https://github.com/hashicorp/vagrant/issues/8055)

## Vagrant and Virtualbox 5.2 working on Mojave!

![All fixed](/assets/images/post-images/2018-07-10-running-vagrant-and-virtualbox-in-mojave-public-beta/Screenshot 2018-07-10 at 16.54.10.png){:class="img-responsive"}
