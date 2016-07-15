# have colors on MacOsX
export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LSCOLORS=ExFxCxDxBxegedabagacad

WRAP='\[\e[7h\]'
GREEN='\[\e[32m\]'
RED='\[\e[31m\]'
NC='\[\e[0m\]'
export PS1="\u@\h:\w"'${debian_chroot:+($debian_chroot)}'"\$ "
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# PROMPT_COMMAND='echo -n -e "\033k${HOSTNAME/.*/}\033\\"'
# PROMPT_COMMAND='echo -n -e "\033kmac\033\\"'
shopt -s extglob
ssh() {
	realargs="$@"
	host="${@:-1}"
	while [ $# -gt 0 ]; do
		if [ "${1:0:1}" == "-" ] ; then # arguments
			# echo arg $1
			[[ "$1" == -[bcDEeFIiLlmOopQRSWw] ]] && { 
				shift # ... with params
				# echo with param
			}
			shift
		else
			host=$1
			# echo host: $host
			break
		fi
	done
	set -- $realargs
	echo -n -e "\033k${host}\033\\"
	/usr/bin/ssh $realargs
	echo -n -e "\033kbash\033\\"
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$PATH:$HOME/.rvm/bin:$HOME/go/bin:/usr/local/go/bin" # Add RVM to PATH for scripting
alias vim='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'

export EDITOR=/usr/local/bin/vim
export GOPATH=$HOME/go

# docker run for fpm
# docker run -v $HOME:$HOME --name fpm --rm -t -i xa/fpm bash

# some bash customizations from https://github.com/mrzoo/bash-sensible/

# automatically trim long paths in the prompt (bash 4.x)
PROMPT_DIRTRIM=3

# turn on recursive globbing
shopt -s globstar 2> /dev/null

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Append to history: don't overwrite
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
# PROMPT_COMMAND='history -a'

# bigger history
HISTSIZE=5000
HISTFILESIZE=50000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# don't record some commands
export HISTIGNORE="exit:ls:bg:fg:history:clear"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

# correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

alias mount="mount | column -t"

export VIMPUPPET="~/stack/git/gitlab/puppet/modules/accounts/files/xnicollet/.vimrc"
alias diffvimrc="vimdiff ~/.vimrc ${VIMPUPPET}"
alias updatevimrc="cp ~/.vimrc ${VIMPUPPET}"

