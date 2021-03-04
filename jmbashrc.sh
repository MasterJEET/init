#!/usr/bin/env bash

# Script to add customization for bash (edit .bashrc)

bashrc=~/.bashrc

header=">>> JM_BASH_CUSTOMIZATOIN | START >>>"
footer="<<< JM_BASH_CUSTOMIZATOIN | END <<<"

### CUSTOMIZATION TO BE ADDED
content="
# $header

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='\[\e[36m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\W]\[\e[m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ '
export WORKON_HOME=~/.virtualenvs

# $footer
"


#### MAIN SECTION ####

if [[ ! -f $bashrc ]]; then
    echo "$bashrc file not found, creating it ..."
    echo "$content" > $bashrc
    echo "Done."
else
    if [ $(grep "$header" $bashrc -c) -eq 0 ]; then
        echo "$content" >> $bashrc
        echo "Customization for bash added"
        echo "Execute \"source ~/.bashrc\" to take effect"
    else
        echo "Customization for bash already added"
    fi
fi
