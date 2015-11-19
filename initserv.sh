#!/bin/bash
shopt -s dotglob

localRepo="${HOME}/tmp/test2"
tmp="${localRepo}/tmp_${0}"
gitdir="https://github.com/jeanmichelcote/serverutils.git"
tmpFlag=0

if [[ ! -d "$tmp" ]]; then
  mkdir -p "$tmp"
  echo "Creating temporary folder"
  tmpFlag=1
fi

read -ra localDotfiles_a <<< \
$( find "$localRepo" ! -path "$localRepo"  -name '.*' -maxdepth 1 | \
  awk '{print $0}' ) #&>/dev/null

#cd "$tmp" &>/dev/null && git clone "$gitdir" .
git clone "$gitdir" "$tmp" &>/dev/null 2>&1 && echo "Cloning $gitdir to $tmp"

read -ra remoteDirs_a <<< \
$( find "$tmp" ! -path "$tmp" -type d -maxdepth 1 | awk '{print $0}' )
if [[ ${#remoteDirs_a} -eq 0 ]]; then 
  echo "Nothing was downloaded from the server."
  rm -rf "$tmp" && echo "Removing temporary folder"
  exit 1
fi

for remdir in "${remoteDirs_a[@]}"; do
  case ${remdir##*/} in
    "scripts"   ) 
                  cp -r "${remdir}" "${localRepo}/bin" 
                  echo "Copying ${remdir} over to ${localRepo}/bin" 
                ;;
    ".git"      ) 
                  cp -r "${remdir}" "$localRepo" 
                  echo "Copying ${remdir} over to ${localRepo}"       
                ;;
    "dotfiles"  ) 
                  for remfile in "$remdir"/*; do
                    for locfile in "${localDotfiles_a[@]}"; do
                      if [[ "${locfile##*/}" == "${remfile##*/}" ]]; then
                        cat "$remfile" >> "$locfile"
                        echo "Appending $remfile to $locfile"
                      fi
                    done
                    cp "$remfile" "$localRepo"
                    echo "Copying $remfile over to $localRepo"
                  done
                ;;
  esac
done
echo "Done iterating through directories"

if [[ $tmpFlag -eq 1 ]]; then
  rm -rf "$tmp"
  echo "Removed temporary folder"
fi

# trap "rm -rf $tmp" EXIT
# for file in "${localDotfiles_a[@]}"; do
#   [[ -d $file ]]                && printf "%-10s %s\n" "Directory:" "$file"  && continue
#   [[ ! "${file##*/}" =~ ^\. ]]  && printf "%-10s %s\n" "File:" "$file"       && continue
#   [[ "${file##*/}" =~ ^\. ]]    && printf "%-10s %s\n" "Dotfile:" "$file"    && continue
# done