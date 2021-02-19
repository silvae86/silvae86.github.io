---
layout: post
title:  "Splitting videos automatically for Google Photos"
date: 2021-02-16 18:14:000 +0100
tags: macOS "google photos" homebrew ffmpeg
comments_id: 16
published: false
---

Google [imposes a limit of 10 GB per video](https://support.google.com/photos/thread/1278118?hl=en&msgid=1279363) on uploads to Google photos. I had some very large videos that I filmed on my iPhone and that Google Photos was refusing to backup. A possible solution is to:

1. Send the videos to the Mac using AirDrop
2. Split them into 8GB Segments
3. Upload them into Google Photos

Enjoy this while you can still upload in [High Quality without the videos counting to your overall storage](https://blog.google/products/photos/storage-changes/)!

## Install ffmpeg

Install [Homebrew](https://brew.sh) if you do not already have it in your Mac. Then, install ffmpeg and 

```bash
brew install ffmpeg
```


```bash
#!/bin/bash
INPUT_FILE=$1

# based on https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
FILENAME=${INPUT_FILE##*/}
INPUT_FILE_NO_EXTENSION=${FILENAME%%.*}

SLICES_LENGTH_IN_SECONDS=0
function calculate_length_in_secs {
	FILE=$1
	echo $(ffprobe -i "$FILE" -show_entries format=duration -v quiet -of csv="p=0")
}

function calculate_length_in_sexagesimal {
	FILE=$1
	echo $(ffprobe -v error -sexagesimal -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 $FILE)
}

FULL_LENGTH_IN_SECONDS=calculate_length_in_secs "$INPUT_FILE"
ITERATION=0
OFFSET_TIMESTAMP="0:00:00.000000"

while [[ $SLICES_LENGTH_IN_SECONDS -lt $FULL_LENGTH_IN_SECONDS ]]; do
	ffmpeg -i "$INPUT_FILE" segment -segment_time -codec copy -fs 8G "$INPUT_FILE"
done

```

Replace the `<input file>` with the absolute path of your input video