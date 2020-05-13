---
layout: post
title:  "Fixing `unable to determine url for /Volumes/TimeCapsule in Apple Time Machine`"
date:   2019-09-10 23:28:000 +0100
tags: macOS catalina time capsule bug
redirect_from:
  - "/macos/catalina/time/capsule/bug/2019/09/10/unable_to_determine_url_for_mount_point_time_machine/"
---

So far, macOS Catalina Beta has been a mixed bag of experiences. After critical crashes to the login screen on Beta 3, Beta 7 seems to be stable enough for daily use.

## Catalina and Time Capsule: not yet ready for prime time

I just bought an Apple Time Capsule 2TB on eBay for automatic backups over Wi-Fi. However, I would get a strange error when setting up the disk in Time Machine preferences:

`Internal error - failed to obtain url for “/Volumes/TimeCapsule”`

## Step by step solution

### Give full disk access to Terminal

Go to System Preferences -> Security and Privacy and add the Terminal app to those with Full Disk Access permissions

![Add Terminal to Full Disk Access](/assets/images/post-images/2019-09-10-unable_to_determine_url_for_mount_point_time_machine/add-terminal-to-full-access.png){:class="img-responsive"}

### Open Terminal

### Open Airport Utility and take note of the IP of your Time Capsule

![Seeing IP of Time Capsule](/assets/images/post-images/2019-09-10-unable_to_determine_url_for_mount_point_time_machine/get-capsule-ip.png){:class="img-responsive"}

### Still in Airport Utility, take note of the name of your disk

![Seeing Disk Name](/assets/images/post-images/2019-09-10-unable_to_determine_url_for_mount_point_time_machine/see-capsule-disk-name.png){:class="img-responsive"}

### Putting the command together

Now that we have all the necessary information, we need to set the Time Machine destination manually. You need a commmand more or less like this:

```shell
sudo tmutil setdestination -ap afp://<<yourusername>>@<<your_capsule_ip>>/<<disk_name>>
```

Let's explain it step by step:

- `sudo`: run with admin previleges
- `tmutil`:  command-line utility for managing Time Machine settings and operations
- `setdestination`: sets the destination of your backups
- `-ap`: `a` - Add destination, `-p` prompt for password in a blind input, so that the password to access the remote disk is not recorded in the Terminal history (you can use `history -c` to clear command history, by the way)
- `afp://<<yourusername>>@<<your_capsule_ip>>/<<disk_name>>`: Connection string to indicate how to access the shared volume.
	- `yourusername` needs to be replaced with the username that you used when configuring the Time Capsule
	- `your_capsule_ip` has to be replaced with what you got in step 3
	- `disk_name` has to be replaced with the name of your disk, that you got in step 4.

### Run the command in Terminal

Your command should now be something like this. **Run it in Terminal**.

```shell
sudo tmutil setdestination -ap afp://joaorocha@10.0.1.1/Capsule
```

### Final Result

The remote capsule disk should now appear in the GUI and you should be able to start a backup:

![Final Result](/assets/images/post-images/2019-09-10-unable_to_determine_url_for_mount_point_time_machine/result.png){:class="img-responsive"}
