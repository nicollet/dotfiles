# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

for t in common `uname` `hostname -s` ; do
  F=~/.bashrc-$t
  [ -f "$F" ] && . $F
done


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
