---
layout: post
title:  "iCloud always full? AirDrop your media to a cleanly organised folder in minutes"
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
9. All this has to use free software, because I need money to pay for the gasoline (€2.30/l in Portugal at time of writing). 

## Selecting a media organisation software

## Setting up phockup on a Mac

## The synchronisation script

## Adding the LaunchDaemon

## Testing it out


[^github-phockup]: "Phockup - Media sorting tool to organize photos and videos from your camera in folders by year, month and day." [Link](https://github.com/ivandokov/phockup)
