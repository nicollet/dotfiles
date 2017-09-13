# If not running interactively, don't do anything

[ -z "$PS1" ] && return

[ -f ~/.bashrc ] && source ~/.bashrc
which rbenv > /dev/null 2>&1 && eval "$(rbenv init -)"

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
