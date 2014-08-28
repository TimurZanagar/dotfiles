#!/bin/bash
#
# git-is-ancestor, by Simon Whitaker
#
# Suggested usage
#
# Store this file somewhere, make it executable, then alias
# it to git is-ancestor by putting this in your $HOME/.gitconfig:
#
# [alias]
#   is-ancestor = !/path/to/git-is-ancestor
#
# Then use thus:
#
# $ git is-ancestor rev1 rev2

script_name=$(basename $0)

usage()
{
    cat << EOF >&2
usage: ${script_name} <REV1> <REV2>
EOF
}

if [ $# -ne 2 ]; then
    usage
    exit 2
fi

if $(git merge-base --is-ancestor $1 $2); then
  echo "$1 is an ancestor of $2"
  exit 0
elif $(git merge-base --is-ancestor $2 $1); then
  echo "$2 is an ancestor of $1"
  exit 0
else
  echo "$1 and $2 are not related"
  exit 1
fi
