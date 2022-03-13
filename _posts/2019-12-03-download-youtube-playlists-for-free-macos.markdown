---
layout: post
title:  "Download music from YouTube for free using macOS"
date:   2019-12-03 16:04:000 +0100
tags: macos youtube download playlist mixtape open source free music
redirect_from:
  - "/macos/youtube/download/playlist/open/source/free/music/2019/12/03/download-youtube-playlists-for-free-macos/"
---

Often you want to download videos from YouTube or extract audio from them.

There is no need to spend money on a GUI tool like [4k Video Downloader](https://www.4kdownload.com) if you know how to use open-source tools like [`youtube-dl`](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#readme). It is really cool, and free!

If you tried to install `youtube-dl` in macOS you may have run into errors like `zlib not installed` etc. etc.

The trick is to install Python 3 using [Homebrew](https://brew.sh) and then run youtube-dl using `python3` instead of the default Python of macOS, which is 2.7.

This was tested in macOS Catalina (10.15.1), macOS Big Sur (11.1) and macOS Monterey (12.1).

## Installation

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

## Downloading a playlist

```bash
youtube-dl https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb -x --audio-format m4a --audio-quality 200k --no-check-certificate --add-metadata --postprocessor-args "-metadata album='Album name, even with spaces!" --embed-thumbnail -o '%(playlist_index)s. - %(title)s.%(ext)s'
```

Explanation of this command, for the curious:

- `youtube-dl` &larr; Base command
- https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb &larr; Playlist address
- `-x` &larr; Extract
- `--audio-format` &larr; Use m4a for the output. You can replace with mp3 if you would like mp3 files.
- `--audio-quality 200k` &larr; Bitrate for the produced files. Higher = more space = better quality
- `--no-check-certificate` &larr; Needed because without this some error would appear 😳
- `--add-metadata --postprocessor-args "-metadata album='Album name, even with spaces!"` &larr; Sets the album name in the ID3 tags of the produced files. The single quotes `'` are needed at the end to handle names with spaces
- `--embed-thumbnail` &larr; Embeds the album art thumbnail in the file (nice for iTunes or whatever player you use).
- `-o '%(track_number)s. - %(title)s.%(ext)s'` &larr; By default, youtube-dl appends the video id to the file names when it downloads videos, even if [some disagree](https://github.com/ytdl-org/youtube-dl/issues/4071) with this behaviour. This makes it so that only the track number, title and the extension make up the file name.

### If you still get errors

If you have issues with the system using Python 2 instead of Python 3 (as it should) try this alternative that calls `python3` directly:

```bash
python3 $(which youtube-dl) https://www.youtube.com/playlist?list=PLamnoxId_aK2qxsln0OiDh9s3Pa1vgfvb -x --audio-format m4a --audio-quality 200k --no-check-certificate "-metadata album=\"Album name, even with spaces!\"" --embed-thumbnail -o '%(playlist_index)s. - %(title)s.%(ext)s'
```

## Downloading a large file and splitting it into several tracks

We will use a script called `album-splitter` that you can find on [GitHub](https://github.com/crisbal/album-splitter). 

### Installing album-splitter

```bash
git clone git@github.com:crisbal/album-splitter.git
cd album-splitter/
python3 -m venv venv
source venv/bin/activate
pip3 install .
```

### Downloading the file from YouTube + Creating the split files


(from the original README [here](https://github.com/crisbal/album-splitter#quick-guide-from-a-local-album)):

+ Copy the YouTube URL of the album you want to download and split
+ Find in the YouTube comments the tracklist with start-time and title
+ Create a copy of the tracks.txt.example, rename it as tracks.txt and
   delete the lines starting with #.
+ Open tracks.txt
+ Copy the tracklist in the file, adjusting for the supported formats
    * `<start-time> - <title>`
    * A track on each line
+ Run the script
    * Basic usage: `python3 -m album_splitter -yt <youtube_url>`
+ Wait for the Download and for the conversion
+ Wait for the splitting process to complete
+ You will find your tracks in the `./splits` folder

### Converting WAVs to AAC

Let's install a WAV to AAC Converter: 

```bash
brew install fdk-aac fdk-aac-encoder
```

Save this as `splits/convert_aac_256.sh`. 

```bash
#!/usr/bin/env bash
for i in *wav; do
    fdkaac -b 256k "$i" &
done
```

Then, run the conversion script inside each sufolder whose files you want to convert, e.g.: 

```bash
cd splits/<subfolder>
../convert_aac_256.sh
```

This runs all conversions in parallel for fastest performance.


### Dowloading an entire channel

Here is another goodie: How to download an entire channel. Replace everything up to CHANNELURL with the link of the channel you want to download, **but keep the `/videos` suffix**.

`youtube-dl -f 'bestvideo[height<=480][ext=mp4]+bestaudio[ext=m4a][height<=480]/mp4' -citw -v  https://www.youtube.com/user/CHANNELURL/videos`

Will download all videos at 480p and in mp4+m4a format for maximum compatibility. Adjust to your preferences.

You can also just replace the link with the link of a playlist to download all videos on that playlist.
