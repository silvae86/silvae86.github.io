---
layout: post
title:  "iCloud always full? Organise your AirDrop photos and old hard drives in minutes"
date: 2022-06-30 22:36:000 +0100
tags: mac storage icloud full media organisation open source automatic duplicates videos pictures 
published: true
comments_id: 49
---

**IN CONSTRUCTION!**

{% include image.html src="/assets/images/post-images/2022-06-30-automatic-media-organisation-and-backup-from-airdrop/icloud-full.png"
caption="iCloud always full! Filming in 4k fills up my iCloud drive in minutes!" imageposition="center"
title="iCloud always bursting at the seams"
%}

Is the image above a familiar sight? To me it is, and I today I am showing you how to implement an automated workflow for organising my media. It goes along these lines:

1. Send my pictures and video to my Mac Mini using AirDrop (Apple's wireless file transfer that works pretty well).
2. The files are saved by AirDrop in a folder in my Mac Mini. 
3. I should not need to log into the machine to AirDrop files into it. Ideally, this workflow should work with only a power and network cable connected to the Mini. 
4. A script detects these new files and, after looking at each file's EXIF metadata (date taken), sends the files to my external hard drive in an organised structure.
5. The hard drive is organised in a simple folder structure: `<year>/<month>/<day>/<filename>`. 
   - Previous experience has taught me that relying on apps like Aperture (deprecated), Apple Photos (more incompatible versions than I remember) or Adobe Lightroom is not a good long-term choice. These apps are nice and beautiful but ultimately make you hostage by holding your photos while they force you to pay/upgrade again and again when and the old one ceases to work on new OS versions or Apple drops support for your machine.
6. Duplicates will be detected and deleted from the target folder to save space.
7. The script shall run continuously in the background, monitoring the folder for new media files, so that I do not need to perform any manual actions. 
8. The script shall use efficient OS mechanisms like `fswatch` (which I previously combined with rsync [here](/2022/05/20/remote-synchronization-using-fswatch-and-rsync/) to avoid having to scan the whole folder continuously. Event handling instead of _polling_, to minimise resource usage.
9. All this has to use free software, because I need money to pay for petrol (€2.30/l in my country at time of writing). 

## Selecting a media organisation software

Like I said, I want to avoid closed-source, large applications by big names like Apple and Adobe, since they tend to need periodic upgrades. In the case of Adobe, such upgrades will ultimately force you into a subscription. In the case of Apple, you may be forced to spend money on a more modern computer as your current one is removed from the list of supported machines. Recently, with the presentation of macOS Ventura we saw an [extreme example of this](https://osxdaily.com/2022/06/22/macos-ventura-compatible-mac-list/), with my 2018 Mac Mini barely escaping the axe. 

What one needs to understand is that pictures and videos are long-lasting digital assets. The iPhoto library where you archived your photos 10 years ago will need to be migrated into the most recent Apple Photos version. For that, you may need to buy an old MacBook, just to pry out the pictures from the library file. And with it, there are no assurances that the metadata (dates, locations, etc.) will be correctly migrated! We should only rely on [EXIF metadata](https://en.wikipedia.org/wiki/Exif) and a simple structure of folders and files for our long-term preservation. 

After a search on GitHub for `media organization`, I selected [phockup](https://github.com/ivandokov/phockup) for this job. It is written in Python and uses [exiftool](https://exiftool.org/), an open-source[^github-exiftool] and platform-independent tool, to extract EXIF data from the pictures and videos. It is also quite easy to install on a Mac using [Homebrew](https://brew.sh/).

## Setting up your Mac


1. Install [Homebrew](https://brew.sh).
2. For macOS Ventura, you may need to install Python from source.
    ```bash
   brew install --build-from-source python@3.9
    ```
3. Install `phockup`'s Python `tqdm` dependency:
    ```bash
    pip3 install tqdm
    ```
4. Install `fswatch` :
    ```bash
    brew install fswatch
    ```
5. Install `phockup` :
    ```bash
    brew tap ivandokov/homebrew-contrib
    brew install phockup
    ```
   
Try running `phockup`. You should see this:

{% include image.html src="/assets/images/post-images/2022-06-30-automatic-media-organisation-and-backup-from-airdrop/phockup-start.png"
caption="Starting up phockup" imageposition="center"
title="Starting up phockup in the Terminal"
%}

## The synchronisation script

The basic requirements are:

- When new files are detected, call `phockup` to organise them to a target folder.
- Only one synchronisation process can execute at any given point in time, to avoid synchronisation conflicts. 
  - We will be using a simple file `.pid` file in the temporary file directory `/tmp` for this.
- If a synchronisation process crashes, the next run should know that the original process crashed and try again.


@see https://superuser.com/questions/28384/what-should-i-do-about-com-apple-quarantine

```bash
#!/usr/bin/env bash

# Set up two folders to monitor. 
# 
# - Downloads folder will be monitored for files sent via AirDrop only
# - DropFolder will be monitored for any files 
AIRDROP_FOLDER="$HOME/Downloads"
DROP_FOLDER="$HOME/Pictures/DropFolder"
TARGET_FOLDER="/Volumes/Backups/Pictures"

echo "Monitoring files AirDropped into $AIRDROP_FOLDER and copied into $DROP_FOLDER...."
echo "Media files will be organised into $TARGET_FOLDER."

# Print lines to Mac's system log Console app
function print_lines_to_system_log() {
  while IFS= read -r line
    syslog -s -k Facility com.apple.console \
             Level Notice \
             Sender Photo Sync Script by silvae86\
             Message "$line"
  done 
}

# Run phockup instance on a folder. Will print logs to 
function organise_folder() {
  local FOLDER_TO_ORGANISE=$1
  phockup "$FOLDER_TO_ORGANISE" "$OUTPUT_FOLDER" --verbose >> print_lines_to_system_log
} 

# Monitor folder for new files using OS-fired events instead of polling (e.g. macOS's `fswatch`)

function monitor_folder() {
  local FOLDER_TO_MONITOR=$1
  fswatch \
    --one-per-batch \
    --recursive \
    --verbose \
    "$FOLDER_TO_MONITOR" | \
    
}

# Filter files based on their quarantine status, including only those sent via AirDrop. This will ignore files downloaded from the internet

# Need to detect a file with a WhereFroms metadata attribute, but the attribute does not include a web address (http://....)
FILE="/Users/joaorocha/Downloads/camphoto_1144747756.JPG" 
xattr -px com.apple.metadata:kMDItemWhereFroms "$FILE" | xxd -r -p | plutil -p -

# Organise all files in the DropFolder. Requires manual copying into it, but is useful for organisation of old hard drives, for example.  

monitor_folder()

```

## Making the synchronisation script run in the background and on startup 

We will use the init system of macOS for starting our synchronisation script in the background whenever the machine starts. 

### Building a _.plist_ file to configure the daemon

### Adding the LaunchDaemon to initctl

## Testing it out


[^airdrop-forensics]: "AirDrop Forensics 2 | by Kinga Kięczkowska" [Link](https://eforensicsmag.com/airdrop-forensics-2-by-kinga-kieczkowska/)

[^stackoverflow-print-all-extended-attriburtes]: "Can you show/list all extended-attributes and how?" [Link](https://superuser.com/questions/858210/can-you-show-list-all-extended-attributes-and-how)

[^parse-binary-property-lists]: "Parse Binary Property Lists in Finder Metadata" [Link](https://scriptingosx.com/2017/08/parse-binary-property-lists-in-finder-metadata/)

[^github-phockup]: "Phockup - Media sorting tool to organize photos and videos from your camera in folders by year, month and day." [Link](https://github.com/ivandokov/phockup)

[^github-exiftool]: "Exiftool on GitHub" [Link](https://github.com/exiftool/exiftool)
