#! /bin/bash

SSH_OPT='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
#SRC="$HOME/stack/git/Github/nicollet/dotfiles/.git"
SRC="$HOME/.git"

[ "x$1" == "x--help" ] && {
  echo "usage: `basename $0` [--help] FILTER_HOSTS"
  echo "  FILTER_HOSTS: which hosts to deploy to (ex: xav). Default: all hosts: ny-|co-"
  exit 0
}
[ -n "$1" ] && FILTER_HOSTS="$1" || FILTER_HOSTS="ny-|co-"

curl -s bosun/api/host | \
  jq ".[]|select( (.OS.Version|strings|test(\"CentOS\")) and (.Name|test(\"$FILTER_HOSTS\")) )|.Name" | \
  #head -1 | \
  while read i ; do
    host=${i//\"}
    rsync -ae "ssh $SSH_OPT" --delete $SRC/ $host:/home/xnicollet/.git/
    ssh -nA $SSH_OPT $host "git reset --hard origin/master ; git submodule init; git submodule update"
  done
