#!/bin/sh
[ ! -d "${HOME}/tmp" ] && mkdir "${HOME}/tmp" && cd "${HOME}/tmp"
git clone https://github.com/jeanmichelcote/serverutils.git .
