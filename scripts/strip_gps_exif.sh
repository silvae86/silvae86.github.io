#!/usr/bin/env bash
IMAGES=$(find . -iname '*.jpg' -print -or -iname '*.png' -print -or -iname '*.jpeg' -print -or -iname '*.gif' -print)
exiftool -r -overwrite_original "-gps*=" .
