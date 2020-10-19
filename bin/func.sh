#! /bin/bash
# interesting functions

append() {
  local var=$1 to_add=$2
  eval "local old_value=\$$var"
  while read -d: k ; do
    [ "$k" == "$to_add" ] && return
  done < <( echo :$old_value: )
  eval "$var='$old_value:$to_add'"
}

prepend() {
  local var=$1 to_add=$2
  eval "local old_value=\$$var"
  while read -d: k ; do
    [ "$k" == "$to_add" ] && return
  done < <( echo :$old_value: )
  eval "$var='$to_add:$old_value'"
}

my_ssh() {
  realargs="$@"
  host="${@:-1}"
  while [ $# -gt 0 ]; do
    if [ "${1:0:1}" == "-" ] ; then # arguments
      [[ "$1" == -[bcDEeFIiLlmOopQRSWw] ]] && { 
        shift # ... with params
      }
      shift
    else
      host=$1
      break
    fi
  done
  set -- $realargs
  _screen_title() {
    screen -X eval "title b"
  }
  trap _screen_title return
  # echo -n -e "\033k${host}\033\\"
  screen -X eval "title ${host}"
  screen -X eval "hstatus ^%{.y}${host}^%{-}"
  /usr/bin/ssh $realargs
}
