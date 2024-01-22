#!/bin/bash

# remove temp files ending in '~' or '#' (emacs make em)
cleanup_temps() {
   for i in `find . -type f -not -path './.git/*'`; do 
       if [[ -f $i && ("${i:(-1)}" == "#" || "${i:(-1)}" == "~") ]]; then
           rm $i
           echo "removed $i"
       fi
   done 
}

cleanup_temps

