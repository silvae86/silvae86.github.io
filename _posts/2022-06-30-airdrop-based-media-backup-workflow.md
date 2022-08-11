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
9. All this has to use free software, because I need money to pay for petrol (€2.30/l in my country at time of writing). 

## Selecting a media organisation software

Like I said, I want to avoid closed-source, large applications by big names like Apple and Adobe, since they tend to need periodic upgrades. In the case of Adobe, such upgrades will ultimately force you into a subscription. In the case of Apple, you may be forced to spend money on a more modern computer as your current one is removed from the list of supported machines. Recently, with the presentation of macOS Ventura we saw an [extreme example of this](https://osxdaily.com/2022/06/22/macos-ventura-compatible-mac-list/), with my 2018 Mac Mini barely escaping the axe. 

What one needs to understand is that pictures and videos are long-lasting digital assets. The iPhoto library where you archived your photos 10 years ago will need to be migrated into the most recent Apple Photos version. For that, you may need to buy an old MacBook, just to pry out the pictures from the library file. And with it, there are no assurances that the metadata (dates, locations, etc.) will be correctly migrated! We should only rely on [EXIF metadata](https://en.wikipedia.org/wiki/Exif) and a simple structure of folders and files for our long-term preservation. 

After a search on GitHub for `media organization`, I selected [phockup](https://github.com/ivandokov/phockup) for this job. It is written in Python and uses [exiftool](https://exiftool.org/), an open-source[^github-exiftool] and platform-independent tool, to extract EXIF data from the pictures and videos. It is also quite easy to install on a Mac using [Homebrew](https://brew.sh/).

## Setting up phockup on a Mac

After Homebrew is installed, install phockup's Python `tqdm` dependency:

```bash
pip3 install tqdm
```

Install phockup itself:

```bash
brew tap ivandokov/homebrew-contrib
brew install phockup
```

Try running `phockup`. You should see this:

{% include image.html src="/assets/images/post-images/2022-06-30-automatic-media-organisation-and-backup-from-airdrop/phockup-start.png"
caption="Starting up phockup" imageposition="center"
title="Starting up phockup in the Terminal"
%}

### Note for macOS Ventura

For macOS Ventura, you may need to install Python from source.

```bash
brew install --build-from-source python@3.9
pip3 install tqdm
brew install phockup
```

## The synchronisation script



## Making the synchronisation script run in the background and on startup 

### Building a _.plist_ file

### Adding the LaunchDaemon

## Testing it out


[^github-phockup]: "Phockup - Media sorting tool to organize photos and videos from your camera in folders by year, month and day." [Link](https://github.com/ivandokov/phockup)

[^github-exiftool]: "Exiftool on GitHub" [Link](https://github.com/exiftool/exiftool)