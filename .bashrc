# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

## functions for setting shell env variables
fbid(){ 
  if [ "$1" ]; then 
    export FACEBOOK_ID="$1"
  fi 
}

fbtoken(){ 
  if [ "$1" ]; then 
    export FACEBOOK_TOKEN="$1"
  fi 
}

picsdir(){
  if [ "$1" ]; then 
    export TINDERPICS_DIR="$1"
  fi 
}

get_token(){ 
  if [ "$1" ]; then 
    fbtoken $(extract_token "$1")
  fi 
}

write_env(){ 
  if [ "$FACEBOOK_ID" ] && [ "$FACEBOOK_TOKEN" ] && [ "$TINDERPICS_DIR" ]; then 
    scrape env > .tndrscrpr
  fi 
}

# misc. functions
response(){ 
  if [ "$1" ]; then 
    echo "$1" > response.$(date | awk '{print $2$3}')_$(date | \
    awk '{print $4}' | sed 's/:/./g')
  fi 
}

# aliases
alias set_env='source .tndrscrpr'

# traps
trap write_env EXIT

# extras
if [ -e .tndrscrpr ]; then set_env; fi
