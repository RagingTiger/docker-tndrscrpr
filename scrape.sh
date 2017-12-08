#!/bin/bash

if [ -z "$1" ]; then
  python /usr/src/tinderGetPhotos.py
else
  case "$1" in
    help|-h) pandoc /usr/src/README.md | lynx -stdin;;
  esac
fi
