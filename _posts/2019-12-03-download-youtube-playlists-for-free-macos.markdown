---
layout: post
title:  "Download YouTube playlists as music for free using macOS"
date:   2019-12-03 16:04:000 +0100
tags: macos youtube download playlist open source free music
redirect_from:
  - "/macos/youtube/download/playlist/open/source/free/music/2019/12/03/download-youtube-playlists-for-free-macos/"
---

Often you want to download videos from YouTube or extract audio from them.

There is no need to spend money on a GUI tool like [4k Video Downloader](https://www.4kdownload.com) if you know how to use open-source tools like [`youtube-dl`](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#readme). It is really cool, and free!

If you tried to install `youtube-dl` in macOS you may have run into errors like `zlib not installed` etc. etc.

The trick is to install Python 3 using [Homebrew](https://brew.sh) and then run youtube-dl using `python3` instead of the default Python of macOS, which is 2.7.

This was tested in macOS Catalina (10.15.1) and macOS Big Sur (11.1)

### Installation

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

# install atomicparsley
brew install atomicparsley
```

### Downloading a playlist


```bash
youtube-dl https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb -x --audio-format m4a --audio-quality 200k --no-check-certificate "-metadata album=\"Album name, even with spaces!\"" --embed-thumbnail -o '%(playlist_index)s. - %(title)s.%(ext)s'
```

Explanation of this command, for the curious:

- `youtube-dl` &larr; Base command
- https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb &larr; Playlist address
- `-x` &larr; Extract
- `--audio-format` &larr; Use m4a for the output. You can replace with mp3 if you would like mp3 files.
- `--audio-quality 200k` &larr; Bitrate for the produced files. Higher = more space = better quality
- `--no-check-certificate` &larr; Needed because without this some error would appear 😳
- `-metadata album=\"Album name, even with spaces!\""` &larr; Sets the album name in the ID3 tags of the produced files. The escaped double quotes `\"` are needed at the end to handle names with spaces
- `--embed-thumbnail` &larr; Embeds the album art thumbnail in the file (nice for iTunes or whatever player you use).
- `-o '%(track_number)s. - %(title)s.%(ext)s'` &larr; By default, youtube-dl appends the video id to the file names when it downloads videos, even if [some disagree](https://github.com/ytdl-org/youtube-dl/issues/4071) with this behaviour. This makes it so that only the track number, title and the extension make up the file name.

#### If you still get errors

If you have issues with the system using Python 2 instead of Python 3 (as it should) try this alternative that calls `python3` directly:

```bash
python3 $(which youtube-dl) https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb -x --audio-format m4a --audio-quality 200k --no-check-certificate "-metadata album=\"Album name, even with spaces!\"" --embed-thumbnail -o '%(playlist_index)s. - %(title)s.%(ext)s'
```
