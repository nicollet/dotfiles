# If not running interactively, don't do anything

[ -z "$PS1" ] && return

[ -f ~/.bashrc ] && source ~/.bashrc


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xnicollet/google-cloud-sdk/path.bash.inc' ]; then source '/Users/xnicollet/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/xnicollet/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/xnicollet/google-cloud-sdk/completion.bash.inc'; fi

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
