#!/usr/bin/env bash

# Script to add customization for bash (edit .bashrc)

bashrc=~/.bashrc

header=">>> JM_BASH_CUSTOMIZATOIN | START >>>"
footer="<<< JM_BASH_CUSTOMIZATOIN | END <<<"

git_completion_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
git_prompt_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

git_completion_file="$(basename $git_completion_url)"
git_prompt_file="$(basename $git_prompt_url)"

git_dir="$(readlink -f $(dirname $0))/git"

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

# git completion
if [[ -f $git_dir/$git_completion_file ]]; then
    source $git_dir/$git_completion_file
fi

# git prompt
if [[ -f $git_dir/$git_prompt_file ]]; then
    source $git_dir/$git_prompt_file
fi

# $footer
"

function download_git_files {

    mkdir -p $git_dir

    if [[ ! -f "$git_dir/$git_completion_file" ]]; then
        curl -o $git_dir/$git_completion_file $git_completion_url
    fi

    if [[ ! -f "$git_dir/$git_prompt_file" ]]; then
        curl -o $git_dir/$git_prompt_file $git_prompt_url 
    fi
}


#### MAIN SECTION ####

download_git_files

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
