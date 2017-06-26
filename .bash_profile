# If not running interactively, don't do anything

[ -z "$PS1" ] && return

[ -f ~/.bashrc ] && source ~/.bashrc
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
