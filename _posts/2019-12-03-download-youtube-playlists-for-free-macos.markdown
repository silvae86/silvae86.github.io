---
layout: post
title:  "Download YouTube playlists as music for free using macOS"
date:   2019-12-03 16:04:000 +0100
categories: macos youtube download playlist open source free music
---

Often you want to download videos from YouTube or extract audio from them. 

There is no need to spend money on a GUI tool like [4k Video Downloader](https://www.4kdownload.com) if you know how to use open-source tools like [`youtube-dl`](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#readme). It is really cool, and free!

If you tried to install `youtube-dl` in macOS you may have run into errors like `zlib not installed` etc. etc. 

The trick is to install Python 3 using [Homebrew](https://brew.sh) and then run youtube-dl using `python3` instead of the default Python of macOS, which is 2.7.

This was tested in macOS Catalina (10.15.1).

```bash
#!/usr/bin/env bash

# install xcode components
xcode-select --install

# install audio encoder
brew install ffmpeg

#install python 3
brew install python3

#install pyenv
brew install pyenv

#install youtube-dl using homebrew
brew install youtube-dl

#install youtube-dl using python3 (this is likely not needed, but whatever...)
pip3 install youtube-dl

# download a playlist using python3, audio format 

python3 $(which youtube-dl) https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb -x --audio-format m4a --audio-quality 200k --no-check-certificate

#python3 $(which youtube-dl) \ 
#	https://www.youtube.com/watch\?v\=ISuuQ0-a5YM\&list\=PL5CCCIHEIDH4udcWyHuFyW2syzsGsYwZM  # your playlist
#	-x \ 				 # Extract audio
#	--audio-format m4a \ 	 # m4a format
#	--audio-quality 200k \ # 200kbps quality
#	--no-check-certificate # avoid certificate unavailable errors
```

