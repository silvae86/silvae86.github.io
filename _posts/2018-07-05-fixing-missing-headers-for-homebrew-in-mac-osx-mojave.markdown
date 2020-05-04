---
layout: post
title:  "Fixing missing headers for homebrew in Mac OS X Mojave"
date:   2018-07-05 16:55:00 +0100
tags: sysadmin mac osx mojave beta libxml2
redirect_from:
  - "/sysadmin/mac/osx/mojave/beta/libxml2/2018/07/05/fixing-missing-headers-for-homebrew-in-mac-osx-mojave/"
---

If, like me, you tried installing `imagemagick` or other software using [Homebrew](https://brew.sh), you might have ran into this error:
{% highlight shell %}
<libxml/parser.h> no such file or directory
{% endhighlight %}

This took me one day to fix, because usually everyone tells you to run `xcode-select --install`. This does not fix the problem.

## Why this happens

Mac OS X 10.14 has stopped placing the include libraries in their usual location, `/usr/include`, keeping them only inside the XCode directory.

To confirm that this is the problem, simply run `ls /usr/include`. If the result comes out empty, its really this problem.

By running `find / | grep libxml/parser.h` I can find the `libxml` library in several places:

{% highlight shell %}
/Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/SDKs/WatchSimulator.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/SDKs/WatchSimulator.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk/usr/include/libxml2/libxml/parser.h
/Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/libxml2/libxml/parser.h
{% endhighlight %}

## What you should not do

Some would say that you should just link the path where the libraries are to `/usr/include`. This is not right, as it overrides the default behaviour expected by Mac OS and requires you to disable SIP (System Integrity Protection). Sometimes it is needed, but this is not one of those times. Leave `csrutil` alone.

You CANNOT modify `/usr/include`, even with the `root` user. It is locked by SIP, so if you try you will get a `Operation not permitted` error.

## What worked for me

Apple ships a "legacy installer" for you to be able to install the headers in the "old location". Run this:

{% highlight shell %}
#copy installer to the desktop
cp /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg ~/Desktop
{% endhighlight %}

Then, the installer will be placed at your Destop. Simple double-click and it will install the headers in `/usr/include`.

or, if you want a pure command line alternative:

{% highlight shell %}
#run installer via command line
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
{% endhighlight %}

## Problem fixed

The `/usr/include` directory now includes all the libraries required by `brew` to link during package compilation:

![end](/assets/images/post-images/2018-07-05-fixing-missing-headers-for-homebrew-in-mac-osx-mojave/Screenshot 2018-07-05 at 17.36.49.png){:class="img-responsive"}

Now `imagemagick` and other kegs will install successfully.
