#!/bin/bash

# Inputs: platforms

supported_platforms=('Windows' 'iOS' 'Android' 'Linux' 'WebGL' 'AppleTV')
IFS='|' read -ra platforms <<< echo $1
for i in "${platforms[@]}"
do
  k=0
  for j in "${supported_platforms[@]}"
  do
    if [[ $i == $j ]]; then
      echo "::set-output name=${i,,}::'true'"
      k=1
    fi
  done
  if [[ k == 0 ]]; then
    echo "$i not supported"
    exit 1
  fi
done
for i in "${supported_platforms[@]}"
do
  if [[ !${platforms[*]} =~ $i ]]; then
    echo "::set-output name=${i,,}::'false'"
  fi
done
