# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

for t in common `uname` `hostname -s` ; do
  F=~/.bashrc-$t
  [ -f "$F" ] && . $F
done

