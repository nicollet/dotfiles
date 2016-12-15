#! /bin/bash

SSH_OPT='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
SRC="$HOME/stack/git/Github/nicollet/dotfiles/.git"

curl -s bosun/api/host | \
  jq '.[]|select( (.OS.Version|strings|test("CentOS")) and (.Name|test("ny-|co-")) )|.Name' | \
  head -1 | \
  while read i ; do
    host=${i//\"}
    rsync -ae "ssh $SSH_OPT" --delete $SRC/ $host:/home/xnicollet/.git/
    ssh -nA $SSH_OPT $host "git reset --hard origin/master ; git submodule init; git submodule update"
  done
