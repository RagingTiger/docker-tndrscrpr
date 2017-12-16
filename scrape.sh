#!/bin/bash

# functions
env_unset(){
  cat <<- EOF
One or more of the shell environment variables has not been set. Here are
the current values of each:

  FACEBOOK_ID: $FACEBOOK_ID
  FACEBOOK_TOKEN: $FACEBOOK_TOKEN
  TINDERPICS_DIR: $TINDERPICS_DIR

Look over the values, find the missing one, set it with the built in
commands (i.e. fbid, fbtoken, picsdir) and try again.
EOF
}

export_env(){
  cat <<- EOF
export FACEBOOK_ID="$FACEBOOK_ID"
export FACEBOOK_TOKEN="$FACEBOOK_TOKEN"
export TINDERPICS_DIR="$TINDERPICS_DIR"
EOF
}

# main
if [ -z "$1" ]; then
  # check shell environment
  if [ -z "$FACEBOOK_ID" ] || \
     [ -z "$FACEBOOK_TOKEN" ] || \
     [ -z "$TINDERPICS_DIR" ]; then
    # notify env variables unset
    echo "$(env_unset)" && exit

  else
    # begin scraping
    python /usr/src/tinderGetPhotos.py
  fi

  # exit
  echo "Scraping complete. Image data stored in: $TINDERPICS_DIR"

else
  case "$1" in
    help|-h) echo "No help ATM :("
    doc|-d) pandoc /usr/src/README.md | lynx -stdin;;
    env|-e) export_env;;
    token|-t) cat /usr/src/README.md | grep '\[link\]' | \
              sed 's/\[link\]/      /g' | awk '{print $9}' | sed 's/[()]//g';;
  esac
fi
