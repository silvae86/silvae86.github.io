---
layout: post
title:  "Automatic synchronization using fswatch and rsync"
date: 2022-05-20 19:00:000 +0100
tags: remote sync rsync fswatch macos command line
published: true 
---

Here is a simple script to automatically synchronize a local directory with a remote one whenever a local change is detected. Combined with a compiler that watches for changes running on the remote server, it can be used to offload heavy compilation tasks to a remote server while using a less powerful computer to edit sources.

This script uses `fswatch` to monitor for changes in the local folder and `rsync` to perform the actual synchronization to the folder on the remote machine. 

It is highly advisable to [configure your SSH keys and hosts](/add-ssh-keys-to-remote-server-for-passwordless-login/) to have a completely seamless synchronization experience (i.e. no constant nagging for passwords).  

```bash
#!/bin/bash

# Configure these variables to your reality
REMOTE_HOST=macpro
REMOTE_FOLDER=/tmp/silvae86.github.io
LOCAL_FOLDER=$(pwd)

# initial sync step
rsync -af --progress . "$REMOTE_HOST:$REMOTE_FOLDER"

# initial check may take some time, later changes may be instant
fswatch \
--one-per-batch \ 
--recursive \
--latency 1 \
--verbose \
"$LOCAL_FOLDER" | xargs -I{} rsync -a --progress "$LOCAL_FOLDER" "$REMOTE_HOST:$REMOTE_FOLDER"
```

Explained: 

- `--one-per-batch` &rarr; bubble/combine events so we do not ask for a sync every time a single file is changed
- `--recursive`	&rarr;	scan directories and subdirectories
- `--latency 1`	&rarr; wait 1 second before triggering sync
- `"$LOCAL_FOLDER"` &rarr;source folder 

Next, a piped command calls `rsync` to sync the local dir to the remote one:

- `rsync -a --progress "$LOCAL_FOLDER" "$REMOTE_HOST:$REMOTE_FOLDER"` &rarr; call rsync to synchronize $LOCAL_FOLDER to $REMOTE_FOLDER on $REMOTE_HOST, via SSH.
