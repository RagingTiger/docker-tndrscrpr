#!/bin/bash

# constants
ENVFILE=.env

# main
if [ -z "$1" ]; then
  # setup environment
  if [ -e "$ENVFILE" ]; then
    # shellcheck source=./.env
    source "$ENVFILE"
  else
    fbid=''
    fbtkn=''
    echo -n "Please provide FACEBOOK_ID: "
    read fbid && export FACEBOOK_ID="$fbid"
    echo -n "Please provide FACEBOOK_TOKEN: "
    read fbtkn && export FACEBOOK_TOKEN="$fbtkn"
  fi

  # begin scraping
  python /usr/src/tinderGetPhotos.py

  # exit
  echo "export FACEBOOK_ID=$FACEBOOK_ID"

else
  case "$1" in
    help|-h) pandoc /usr/src/README.md | lynx -stdin;;
  esac
fi
