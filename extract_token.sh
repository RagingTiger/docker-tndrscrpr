#!/bin/bash

# functions
get_token(){
  # extract token
  local token
  token="$(cat $1 | sed 's/access_token=/          /g' | \
  sed 's/&expires_in=/          /g' | awk '{print $3}')"

  # return token
  echo "$token"
}

if [ "$1" ]; then
  # get token and export
  echo "FACEBOOK_TOKEN=$(get_token $1)"
fi
