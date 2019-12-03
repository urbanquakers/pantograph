#!/bin/bash

_pantograph_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local completions=""

  # look for Pantfile either in this directory or pantograph/ then grab the lane names
  if [[ -e "Pantfile" ]]; then
    file="Pantfile"
  elif [[ -e "pantograph/Pantfile" ]]; then
    file="pantograph/Pantfile"
  elif [[ -e ".pantograph/Pantfile" ]]; then
    file=".pantograph/Pantfile"
  fi

  # parse 'beta' out of 'lane :beta do', etc
  completions=$(grep "^\s*lane \:" $file | awk -F ':' '{print $2}' | awk -F ' ' '{print $1}')
  completions="$completions update_pantograph"

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

