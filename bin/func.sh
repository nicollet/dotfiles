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

