---
layout: post
title:  "Using a vintage Mac with 10.6 Snow Leopard in 2022"
date: 2022-03-07 18:10:000 +0100
tags: vintage computing mac osx macbook pro snow leopard afp mount powerbook g4
permalink: /posts/using-a-vintage-mac-with-106-snow-leopard-in-2022
published: true
inconstruction: true
---

Here is a guide on how to use [AFP (Apple Filing Protocol)](https://en.wikipedia.org/wiki/Apple_Filing_Protocol) shares to offload heavy compilation operations to a more modern and powerful machine, while using a vintage Mac for simple text editing and viewing the compiled result in the web browser. This may be of use to those of you running older PowerPC Macs, such as the 12-inch Powerbook G4, one of the most beautiful computers ever created. As long as its Mac OS X version supports AFP, you should be good to go. 

I am using the [source code of this very blog](http://github.com/silvae86/silvae86.github.io) as a test case. 

## Compiling this blog remotely via an AFP share

[It's no secret that I like](/2022/03/10/a-tale-of-mac-computers-since-2007) to use completely outdated/unsafe but absolutely beautiful operating systems to write my blog posts. I never take them outside of the house, log into any website, or connect them to a public Wi-Fi network, though!

Anyway... I set out to find a way to use my MacBook as a text editing and music playing machine, so I can use the old [TextMate](https://macromates.com) 1.5 and [Omnigraffle](https://www.omnigroup.com/omnigraffle/) 5 Pro. At the same time, I can use a much more recent and more powerful computer to compile the sources of this blog.

It's easy to use a flash drive to transfer an entire project between machines and compile it in the more recent one. It is also easy to use Screen Sharing to work remotely on the more modern machine. Instead of using these methods, will use AFP shares to mount the folder in the vintage Mac on the modern machine. We then start the [Jekyll server](https://jekyllrb.com) that automatically compiles this website when any file in the volume is modified on the host machine (the vintage Mac).

This has advantages when compared to keeping the source files and server running in the more modern machine and simply sharing the whole folder to the older machine. You never lose changes if the network goes down, since `⌘S` will always work, because your text editor will always load a *local* file. It is faster, because the editor indexes from your local hard drive and thus does not have to scan the volume every time you perform a fuzzy file open with `⌘T` on Textmate.

![Architecture overview](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/MountAFPVolumesDiagram.png){:class="img-center"}
*Mounting AFP Share (Snow Leopard) in modern machine*{:class="img-caption"}

## Sharing the folder

Here I will be using a folder named `silvae86.github.io`, which is the default name of the folder that `git` creates when I clone the [repository of this blog](https://github.com/silvae86/silvae86.github.io). Adjust to your own reality.

First, enable File Sharing on the left. 

![Sharing 1](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/sharing_1.png)

Click the `+` button and the folder that you want to share.

![Sharing 2](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/sharing_2.png)

![Sharing 3](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/sharing_3.png)

![Sharing 4](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/sharing_4.png)

Do not forget to remove Read Access by Everyone, unless you want anyone on the network to be able to read your data.

![Sharing Remove Read Access](/assets/images/post-images/2022-03-04-using-a-vintage-mac-with-106-snow-leopard-in-2022/sharing_remove_read_access.png)

## Mounting the shared folder on the server

This script was written to perform a series of commands from the older mac into the newer one, allowing you to work on a completely *headless* server (i.e. without even a display connected).

Before specifying the host, I recommend generating a pair of public-private keys and installing your public key on your server. This is much more secure than using a password since a key is much much longer (thus almost impossible to break by brute force) and avoids having to memorize the passwords.

```bash
#!/bin/bash

# 
#  mount-and-compile.sh
#  silvae86.github.io
#  
#  Created by João Rocha da Silva on 2022-03-09.
#  Copyright 2022 João Rocha da Silva. All rights reserved.
# 

# =============================================================
# = Function to encode the url of the shared folder =
# = Credits: https://gist.github.com/cdown/1163649 =
# =============================================================

urlencode() {
    # urlencode <string>

    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

# ========================================================
# = Machine where sources are supposed to be shared from =
# ========================================================

# This is basically the old machine where you are editing the sources

# By default, this machine's host
SHARE_HOST=$(hostname) 	

# Same share name as in the Sharing preferences after adding a new shared folder
SHARE_NAME="silvae86.github.io"

# By default, your own username
SHARE_USER=$(whoami)	

# ==========================================================================
# = Machine that will mount the sources to compile them and serve the blog =
# ==========================================================================

# Network host of the machine that will perform the compilation
COMPILATION_HOST='macpro'

# Instead of using /Volumes/.... I will mount everything in the user's own home folder, under a MountPoints subfolder.
# Avoid needless use of sudo found everywhere on the web when you search about mounts in OS X
COMPILATION_HOST_MOUNTPOINT="\$HOME/MountedVolumes/${SHARE_HOST}/${SHARE_NAME}"

# Command that will be run at the compilation host to compile the blog on any modification and serve it
COMPILATION_COMMAND="./serve.sh"

# ==========
# = Script =
# ==========

# Read password to the remote host
echo "Enter your password (${SHARE_USER}'s password at ${SHARE_HOST}):"
read -s SHARE_HOST_PASSWORD

# Encode URL components to avoid problems with special characters in the mount URLs
AFP_MOUNT_URL=afp://$(urlencode ${SHARE_USER}):$(urlencode ${SHARE_HOST_PASSWORD})@$(urlencode ${SHARE_HOST})/$(urlencode $SHARE_NAME)

# uncomment for debugging if you get mounting errors, to check if your password is correctly escaped
#echo "AFP MOUNT URL: ${AFP_MOUNT_URL}"

# Run remote commands on compilation machine to mount the sources folder from the Share and perform the compilation
# -tt will force the allocation of a tty for this ssh session (to stream compilation output)


ssh -tt "${COMPILATION_HOST}" << EOF 
# Disable history so that your password will not be logged in history,
# although it will be printed on the terminal window
unset HISTFILE
# Create mount point
mkdir -p "${COMPILATION_HOST_MOUNTPOINT}"
# Mount remote directory into mount point
mount -t afp "${AFP_MOUNT_URL}" "${COMPILATION_HOST_MOUNTPOINT}"
# Go to the mounted share
cd "${COMPILATION_HOST_MOUNTPOINT}"
# Compile from the mounted volume
$COMPILATION_COMMAND
EOF

echo "Bye!"

# List all mounted shares
# df
```

## Some awesome applications with support for vintage Macs

- [Max - Audio Converter & CD Ripper](https://sbooth.org/Max)










 






