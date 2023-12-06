#!/bin/bash

curdir="$(cd $(dirname $0); pwd)"

echo ${curdir}

exit 0

cd "${curdir}"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp ./vimrc "${HOME}/.vimrc"

exit 0
