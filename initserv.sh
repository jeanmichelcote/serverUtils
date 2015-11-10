#!/bin/bash
shopt -s dotglob

localRepo="${HOME}/tmp/test2"

tmp="${localRepo}/tmp"
read -ra localFiles_a <<< $( find "$localRepo" ! -path "$localRepo"  -name '.*' -maxdepth 1 | awk '{print $0}' )

[[ ! -d "$tmp" ]] && mkdir -p "$tmp"
cd "$tmp" &>/dev/null && git clone https://github.com/jeanmichelcote/serverutils.git .

read -ra remoteDirs_a <<< $( find "$tmp" ! -path "$tmp" -type d -maxdepth 1 | awk '{print $0}' )

for remdir in "${remoteDirs_a[@]}"; do
  case ${remdir##*/} in
    "scripts"   ) 
                  cp -r "${remdir}" "${localRepo}/bin"  
                ;;
    ".git"      ) 
                  cp -r "${remdir}" "$localRepo"        
                ;;
    "dotfiles"  ) 
                  for remfile in "$remdir"/*; do
                    for locfile in "${localFiles_a[@]}"; do
                      if [[ "${locfile##*/}" == "${remfile##*/}" ]]; then
                        cat "$remfile" >> "$locfile"
                      else
                        cp "$remfile" "$localRepo"
                      fi
                    done
                  done
                ;;
  esac
done
rm -rf "$tmp"

# for file in "${localFiles_a[@]}"; do
#   [[ -d $file ]]                && printf "%-10s %s\n" "Directory:" "$file"  && continue
#   [[ ! "${file##*/}" =~ ^\. ]]  && printf "%-10s %s\n" "File:" "$file"       && continue
#   [[ "${file##*/}" =~ ^\. ]]    && printf "%-10s %s\n" "Dotfile:" "$file"    && continue
# done