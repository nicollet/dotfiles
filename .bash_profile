# If not running interactively, don't do anything

[ -z "$PS1" ] && return

[ -f ~/.bashrc ] && source ~/.bashrc

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
