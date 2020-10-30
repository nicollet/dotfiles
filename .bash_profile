# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# shellcheck source=/Users/nicollet/.bashrc
[ -f ~/.bashrc ] && source ~/.bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xnicollet/projects/gcp/google-cloud-sdk/path.bash.inc' ]; then . '/Users/xnicollet/projects/gcp/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/xnicollet/projects/gcp/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/xnicollet/projects/gcp/google-cloud-sdk/completion.bash.inc'; fi
