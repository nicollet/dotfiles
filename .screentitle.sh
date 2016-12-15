#!/bin/bash
wintitle () { printf "\033k$1\033\\"; }

xtitle() {
    if [ $TERM = "screen" ];
        then case $1 in
#            bt*) wintitle BitTorrent;;
#            gnuclient*) wintitle XEmacs;;
# #           m|mc) wintitle MidCo;;
#            wget*) wintitle WGet;;
#	    em*) wintitle emacs;;
#	    vi*) wintitle $1;;
#	    mutt*) wintitle mutt;;
#	    slrn*) wintitle slrn;;
            *) wintitle `hostname`;;
        esac;
    fi }

title() {
    xtitle "$(history 1 | awk '{ print $2 }')"
}
#trap 'xtitle "$(history 1 | cut -b 8-30)"' DEBUG
trap title DEBUG
