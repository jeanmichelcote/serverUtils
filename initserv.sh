#!/bin/sh
mydir="${HOME}/tmp"
imported="dotfiles scripts"
echo "$imported"
exit 0
[ ! -d "$mydir" ] && mkdir "$mydir"
cd "$mydir"
#git clone https://github.com/jeanmichelcote/serverutils.git .

files="${mydir}/dotfiles/*"
for f in $files; do
	 echo "Processing $f file..."
done

# cp dotfiles/* .