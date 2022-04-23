#!/bin/bash

# remove temp files ending in '~' or '#', or non-git dotfiles
cleanup_temps() {
   for i in `ls -a1`; do 
       if [[ -f $i && ("${i:(-1)}" == "#" || "${i:(-1)}" == "~" || 
           ("${i:0:1}" == "." && $i != ".git"*)) ]]; then 
           rm $i
           echo "removed $i"
       fi
   done 
}

cleanup_temps

