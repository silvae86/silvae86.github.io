---
layout: post
title:  "Splitting videos automatically by length using ffmpeg and the Terminal"
date: 2021-02-16 18:14:000 +0100
tags: macOS ffmpeg split videos homebrew ffmpeg terminal
comments_id: 22
---

Google [imposes a limit of 10 GB per video](https://support.google.com/photos/thread/1278118?hl=en&msgid=1279363) on uploads to Google photos. I had some very large videos that I filmed on my iPhone and that Google Photos was refusing to backup. A possible solution is to:

1. Send the videos to the Mac using AirDrop
2. Split them into 8GB Segments
3. Upload them into Google Photos

Enjoy this while you can still upload in [High Quality without the videos counting to your overall storage](https://blog.google/products/photos/storage-changes/)!

## Install ffmpeg

Install [Homebrew](https://brew.sh) if you do not already have it in your Mac. Then, install `ffmpeg`:

```bash
brew install ffmpeg
```

Now, here is a script that will split a file into segments with a maximum file size. The first argument of the script is the path of the file to be split, and the second argument is the maximum size of the segments, e.g. `10M` for 10 Megabytes or `8G` for 8 Gigabytes.

The script is designed to copy the video and audio streams directly instead of recompressing the file, which would take longer and reduce the quality of the resulting files.

```bash
#!/bin/bash

display_usage() {
	echo "You must provide two arguments for this script. First, the full path to the file to split, and then the maximum size of each segment (e.g. 8G will split the files up to 8GB segments each.)"
	echo -e "\nUsage: $0 <input_file> <segment_size> \n"
}

# if less than two arguments supplied, display usage
if [  $# -lt 2 ]
then
	display_usage
	exit 1
fi

INPUT_FILE="$1"
SEGMENT_SIZE="$2"

# based on https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
FILENAME=${INPUT_FILE##*/}
INPUT_FILE_NO_EXTENSION=${FILENAME%%.*}
EXTENSION="${FILENAME##*.}"

function calculate_length_in_secs {
	FILE="$1"
	LENGTH=$(ffprobe -i "$FILE" -show_entries format=duration -v quiet -of csv="p=0")
	echo "${LENGTH%.*}"
}

FULL_LENGTH=$(calculate_length_in_secs "$INPUT_FILE")
OFFSET_TIMESTAMP=0
SEGMENT_NUMBER=0
while [[ $OFFSET_TIMESTAMP < $FULL_LENGTH ]]; do
	((SEGMENT_NUMBER++))
	echo "Processing segment $SEGMENT_NUMBER..."
	OUTPUT_FILE="$INPUT_FILE_NO_EXTENSION-segment-$SEGMENT_NUMBER.$EXTENSION"

	if [[ $OFFSET_TIMESTAMP -gt 0 ]]; 
	then
		ffmpeg -i "$INPUT_FILE" -map 0 -c copy -ss "$OFFSET_TIMESTAMP" -fs "$SEGMENT_SIZE" "$OUTPUT_FILE"
	else
		ffmpeg -i "$INPUT_FILE" -map 0 -c copy -fs "$SEGMENT_SIZE" "$OUTPUT_FILE"
	fi
	
	LENGTH_OF_SEGMENT=$(calculate_length_in_secs "$OUTPUT_FILE")
	echo "Segment $SEGMENT_NUMBER is $LENGTH_OF_SEGMENT seconds long."
    OFFSET_TIMESTAMP=$((OFFSET_TIMESTAMP+LENGTH_OF_SEGMENT))
	echo "Next segment will start from $OFFSET_TIMESTAMP"
done

echo "Completed splitting of $INPUT_FILE into $SEGMENT_NUMBER segments."
```
