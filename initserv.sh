#!/bin/bash
shopt -s dotglob

nameAlreadyUsed() {
#: Description:         Verifies if the name entered as second argument exists
#:                      in the directory path entered as first argument
#: Options:             
#:                 -f   Searches for a function name.
#:                      If this flag is up, no path should be entered as first
#:                      argument but rather only the name of the function.
#: Arguments:       
#:                 $1   Path to search
#:                 $2   Name to target
#: a
#: (exemple):           nameAlreadyUsed "path/to/dir/" "newname"
#:                      nameAlreadyUsed -f funcname

  local dest name nameUsed OPTIND

  dest="$1"
  name="$2"

  [[ "$#" -ne 2 ]] && printusage -H >&2 && return 1

  while getopts ":f" opt; do
    case $opt in
      f)  nameUsed=$( grep "$name" <(funx) )
          if [[ -n "$nameUsed" ]]; then
            msg_alert "This function name is already used. Please choose another one."
            sleep 1.5
            funx "$name"
            exit 1
          fi
      ;;
      *) return 1  ;;
    esac
  done
  shift $(( OPTIND - 1))

  if [[ -f "${dest}/${name}" ]]; then
    msg_alert "The name chosen for your new script is already used. Please choose another name."
    exit 1
  fi
} 

mydir="${HOME}/tmp"

[ ! -d "$mydir" ] && mkdir "$mydir"
cd "$mydir"

#git clone https://github.com/jeanmichelcote/serverutils.git .

for f in $files; do
	 echo "Processing $f file..."
done

# cp dotfiles/* .