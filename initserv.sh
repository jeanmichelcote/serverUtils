#!/bin/sh

nameAlreadyUsed() {
  #: Description:         Verifies if the name entered as second argument exists
  #:                      in the directory path entered as first argument
  #: Arguments:       
  #:                 $1   Path to search
  #:                 $2   Name to target
  #: a
  #: (exemple):           nameAlreadyUsed "path/to/dir/" "newname"
  #:                      nameAlreadyUsed -f funcname

  local dest name OPTIND

  dest="$1"
  name="$2"

  if [ -f "${dest}/${name}" ]; then
    # msg_alert "The name chosen for your new script is already used. Please choose another name."
    exit 1
  fi
} 

main() {
  mydir="${HOME}/tmp"

  [ ! -d "$mydir" ] && mkdir "$mydir"
  cd "$mydir"

  git clone https://github.com/jeanmichelcote/serverutils.git .
  
  for dir in ./*; do
    dir=${dir%*/}
    echo ${dir##*/}
  done

  # find . -maxdepth 1 -mindepth 1 -type d -printf '%f\n'

#  for f in $files; do
#     echo "Processing $f file..."
#  done

  # cp dotfiles/* .
}

main