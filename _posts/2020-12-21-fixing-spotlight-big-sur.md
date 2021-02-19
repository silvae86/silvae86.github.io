---
layout: post
title:  "Fixing no Spotlight results on macOS Big Sur"
date: 2020-12-20 09:40:000 +0100
tags: macOS big sur spotlight index
comments_id: 15
---

After upgrading to macOS Big Sur I noticed that Spotlight would no longer list any local applications or files.

### Diagnosing the problem

Open Terminal, and type `sudo mdutil -sa`. Your password will be requested. You will see something like this:

```sh
sudo mdutil -sa
Password:
/:
	Indexing and searching disabled.
/System/Volumes/Data:
	Indexing enabled.
```

### Enabling indexing at the filesystem root

In my system, I had `Indexing and searching disabled.` for `/`. I had to enable it again, using these commands:

```sh
cd /
sudo mdutil -a -i on
```

Resulting output:

```sh
/:
	Indexing enabled.
/System/Volumes/Data:
	Indexing enabled.
```

Done! Indexing is now enabled for `/` and Spotlight starts indexing again (you will see the progress bar when pressing Cmd+Space).

After a while, local apps and files start appearing in the list.

### BONUS: Enable indexing of external hard drives

Run this Terminal command:

```bash
sudo defaults write /Library/Preferences/com.apple.SpotlightServer.plist ExternalVolumesIgnore -bool False
```

Then, go to your external hard drive directory (using `cd`) and enter:

```bash
➜  Backups sudo mdutil -a -i on
/:
	Indexing enabled.
/System/Volumes/Data:
	Indexing enabled.
/Volumes/Backups:
	Indexing enabled.
```

You will see `Indexing enabled` just below your external hard drive.

To disable indexing of external hard drives again, run this:

```bash
sudo defaults write /Library/Preferences/com.apple.SpotlightServer.plist ExternalVolumesIgnore -bool True
```

You will see `Indexing and searching disabled.` this time around.

```bash
/:
	Indexing enabled.
/System/Volumes/Data:
	Indexing enabled.
/Volumes/Backups:
	Indexing and searching disabled.
```


