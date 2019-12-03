#!/bin/zsh

_pantograph_complete() {
  local word completions
  word="$1"

  # look for Pantfile either in this directory or pantograph/ then grab the lane names
  if [[ -e "Pantfile" ]] then
    file="Pantfile"
  elif [[ -e "pantograph/Pantfile" ]] then
    file="pantograph/Pantfile"
  elif [[ -e ".pantograph/Pantfile" ]] then
    file=".pantograph/Pantfile"
  fi

  # parse 'beta' out of 'lane :beta do', etc
  completions=`cat $file | grep "^\s*lane \:" | awk -F ':' '{print $2}' | awk -F ' ' '{print $1}'`
  completions="$completions
update_pantograph"

  reply=( "${(ps:\n:)completions}" )
}

