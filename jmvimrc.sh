#!/usr/bin/env bash

# Script to add customization for vim (edit .vimrc)

vimrc=~/.vimrc

header=">>> JM_VIM_CUSTOMIZATOIN | START >>>"
footer="<<< JM_VIM_CUSTOMIZATOIN | END <<<"

### CUSTOMIZATION TO BE ADDED
content="
\" $header

filetype plugin indent on

\" show existing tab with 4 spaces width
set tabstop=4

\" when indenting with '>', use 4 spaces width
set shiftwidth=4

\" On pressing tab, insert 4 spaces
set expandtab

\" Set row number
set nu

\" $footer
"


#### MAIN SECTION ####

if [[ ! -f $vimrc ]]; then
    echo "$vimrc file not found, creating it ..."
    echo "$content" > $vimrc
    echo "Done."
else
    if [[ $(grep "$header" $vimrc -c) -eq 0 ]]; then
        echo "$content" >> $vimrc
        echo "Customization for vim added"
    else
        echo "Customization for vim already added"
    fi
fi
