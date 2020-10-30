# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo ".bashrc"
set -o vi

# WRAP='\[\e[7h\]'
# GREEN='\[\e[32m\]'
# RED='\[\e[31m\]'
# NC='\[\e[0m\]'

# shellcheck source=/Users/nicollet/bin/func.sh
source $HOME/bin/func.sh

prepend PATH "$HOME/bin:/usr/local/sbin:/usr/local/bin"
append PATH "/usr/local/mysql/bin"
p=""
while read -r -d: dir ; do
  append p "$dir"
done < <(echo "${PATH}:")
PATH=${p:1}
unset p
export PATH

bind -m emacs '"\ea": vi-editing-mode'

bind -m vi '"j": next-history'
bind -m vi '"k": previous-history'
bind -m vi '"z": emacs-editing-mode'
bind -m vi '"\ea": emacs-editing-mode'
bind -m vi '"\C-N": next-history'
bind -m vi '"\C-P": previous-history'
bind -m vi '"\C-l": clear-screen'
bind -m vi '"\C-e": end-of-line'
bind -m vi '"\C-k": kill-line'
bind -m vi-command '".":insert-last-argument'

bind -m vi-insert '"\ea": emacs-editing-mode'
bind -m vi-insert '"\C-l": clear-screen'
bind -m vi-insert '"\C-e": end-of-line'
bind -m vi-insert '"\C-k": kill-line'
bind -m vi-insert '"\C-N": next-history'
bind -m vi-insert '"\C-P": previous-history'
bind -m vi-insert '"\C-[": vi-movement-mode'
bind -m vi-insert '"jk": vi-movement-mode'
bind -m vi-insert '"\C-a": beginning-of-line'
bind -m vi-insert '"\C-d": delete-char'
# bind -m vi-insert "\C-w.":backward-kill-word


export GOPATH=$HOME/go

shopt -s extglob

# Append to history: don't overwrite
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

alias sd='screen -DR'
alias ssh=my_ssh

# bigger history
HISTSIZE=5000
HISTFILESIZE=50000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# don't record some commands
HISTIGNORE="exit:ls:bg:fg:history:clear:r"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

alias sudo="sudo -E"
# alias cdd="cd"

# to launch vim
bind '"\C-xe": edit-and-execute-command'
bind '"\C-x;": edit-and-execute-command'

# needed for vim backups
mkdir -p ~/.vim/{tmp,backup}

# automatically trim long paths in the prompt (bash 4.x)
PROMPT_DIRTRIM=3

# complete only on diretories for those commands
complete -d cd
complete -d rmdir


# have colors on MacOsX
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export SCREENRC=.screenrc-Darwin

FG_RED="\[$(tput setaf 1)\]"
RESET="\[$(tput sgr0)\]"

_idroot() {
  whoami | grep -q '^root$'
}

_idcolor() {
   _idroot && echo "${FG_RED}\\\$${RESET}" || echo '$'
}

PS1="${USER/xnicollet/}@:\w$(_idcolor) "
export PS1

set_ps1() {
  [ -z "$STY" ] && return
  PWD_=${PWD/\/Users\/xnicollet/\~}
  screen -X eval "hstatus '$PWD_'"
}

PROMPT_COMMAND=set_ps1

append PATH "/usr/local/go/bin"
append PATH "${HOME}/projects/gcp/google-cloud-sdk/bin"
export PATH

alias vim='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'

export EDITOR=/usr/local/bin/vim

# docker run for fpm
# docker run -v $HOME:$HOME --name fpm --rm -t -i xa/fpm bash

# some bash customizations from https://github.com/mrzoo/bash-sensible/

# turn on recursive globbing
shopt -s globstar 2> /dev/null

# correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

alias mount="mount | column -t"


# update_cdstat() {
#   local max_stat=100
#   [ "$1" == "" ] && return
#   local newpath=$1
#   # count date_sec path
#   local found=0
#   local now
#   now=$(date +%s)
#   { while read -r count date path ; do
#     [ "$path" == "$newpath" ] && { ((count++)) ; date=$now ; found=1 ; }
#     echo "$count $date $path"
#   done < ~/.cdstat
#   [ "$found" -eq 0 ] && echo "1 $now $newpath"
#   } | sort -nr | tail -$max_stat > ~/.cdstat.tmp
#   sync
#   mv ~/.cdstat{.tmp,}
# }

# use the go binary if available (10 times faster)
# go get github.com/nicollet/update_cdstats
update_cdstat_command=$(which update_cdstats || echo update_cdstat)


gnuls() {
  /usr/local/Cellar/coreutils/8.27/libexec/gnubin/ls "$@"
}

# cd() {
#   local realpath
#   [[ "${1}" == -* || "$1" == "" ]] || {
#     realpath=$(realpath "$1") # check realpath before we cd into new dir
#   }
#   builtin cd "$@" && {
#     [[ -n "$realpath" ]] && "$update_cdstat_command" "$realpath"
#     # print below cursor
#     local tmp
#     tmp=$(mktemp)
#     trap "rm -f ${tmp}" RETURN
#     width="--width=$(tput cols)"
#     gnuls -U --color -F $width -C | tee $tmp | head -1
#     [ "$(wc -l <$tmp)" -gt 3 ] && echo "$(tput setaf 6)/.../$(tput sgr0)"
#   }
# }

# cdpath=$(realpath ~/.cdd_path)
# [ -f "$cdpath" ] || touch "$cdpath"

# _fzf_compgen_dir() {
#   sed 's/\s*#.*//' < "$cdpath" | grep -v '^$' | cat - <(cut -d' ' -f3- ~/.cdstat) | sort -u
# }

# cdp() {
#   [ -n "$1" ] && dir=$(realpath "$1") || dir=$(pwd)
#   grep -q -F -x "$dir" "$cdpath" || echo -e "$dir" >> "$cdpath"
# }
#
# cdrm() {
#   local filter=()
#   [ -n "$1" ] && filter=(-q $1)
#   local to_rm
#   to_rm=$(fzf +m "${filter[@]}" < "$cdpath")
#   # https://unix.stackexchange.com/a/204378/144167
#   [ -n "$to_rm" ] && {
#     grep -v -F -x -- "$to_rm" < "$cdpath"
#     perl -e 'truncate STDOUT, tell STDOUT'
#   } 1<> "$cdpath"
# }
#
# cdls() {
#   cat "$cdpath"
# }
#
# function _cd_comp() {
#   #echo "|${READLINE_LINE:$READLINE_POINT:1}|"
#
#   local words=()
#   read -r -a words < <(echo "$READLINE_LINE")
#   [ -z "$words" ] && return
#   local last=${words[-1]}
#   local search=""
#   [ "$last" == "" ] || search="-q $last"
#   opt="--bind tab:accept --expect tab,return"
#   fzf="fzf --tiebreak=end,index $search --reverse --height 30% "
#   #local found=$(_fzf_compgen_dir | $fzf $opt)
#
#   keyf=$(mktemp)
#   pathf=$(mktemp)
#   trap "rm $keyf $pathf" RETURN
#   _fzf_compgen_dir | $fzf $opt | {
#     IFS= read -r key && IFS= read -r path
#     echo $key >$keyf
#     echo $path >$pathf
#   }
#
#   IFS= read -r key <$keyf
#   IFS= read -r path <$pathf
#
#   # if we are completing an empty word
#   local b=$(( READLINE_POINT - 1))
#   [[ ${READLINE_LINE:$b:1} == " " ]] && words+=('replace_me')
#
#   words[-1]=$path
#
#   READLINE_LINE=${words[*]}
#   READLINE_POINT=${#READLINE_LINE}
#
#   [ "$key" == "return" ] && {
#     builtin bind -r "\er"
#     builtin bind '"\e^": accept-line'
#     return
#   }
#
#   builtin bind '"\er": redraw-current-line'
#   builtin bind '"\e^": magic-space'
# }

# test some bindings
# bind -x '"\C-x2": _cd_comp'

# fixme c-o
stty discard undef
# no ctrl-s
stty -ixon
bind -r "\C-o"

bind '"\C-of": "\C-x2\e^\er"'
bind '"\C-oo": operate-and-get-next'

bind -m vi-insert '"jk": vi-movement-mode'

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
