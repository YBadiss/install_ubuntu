#!/bin/bash

export PATH=$PATH:~/bin

source ~/.git-completion.bash

function parse_git_dirty {
  number_changes=$(git status --porcelain 2> /dev/null | grep "^[^\?\!]" | wc -l)
  #last_line=$(git status 2> /dev/null | tail -n1)
  #[[ $last_line != "nothing to commit (working directory clean)" ]] && echo "*"
  [[ $number_changes -ne 0 ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}

function virtualenv_info {
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($venv) "
}

_git_back() {
    __gitcomp_nl "$(previous_branches 5 5)"
}

_git_fixup() {
    __gitcomp_nl "$(git log --pretty=oneline -5)"
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1


function proml {
  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local BK="\[\033[1;30m\]"
  local BR="\[\033[1;31m\]"
  local BG="\[\033[1;32m\]"
  local BY="\[\033[1;33m\]"
  local BB="\[\033[1;34m\]"
  local BM="\[\033[1;35m\]"
  local BC="\[\033[1;36m\]"
  local BW="\[\033[1;37m\]"

  PS1="\$(virtualenv_info)$BW\u@\$(kenv):$C\w $Y\$(parse_git_branch)\

$W\$ "

  PS2='> '

  PS4='+ '

}

proml

_ssh()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh

alias ls="/usr/local/bin/gls -Gh --color --group-directories-first"
alias ll="ls -lahF"
alias grep="grep --color=auto"
alias psef="ps -ef | grep"

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export WORKON_HOME=~/.virtualenvs

function curry() {
    exportfun=$1; shift
    fun=$1; shift
    params=$*
    cmd=$"function $exportfun() {
        more_params=\$*;
        $fun '$params' \$more_params;
    }"
    eval $cmd
}

# Basic autocomplete method which accepts a single argument as the method to run to produce the
# autocomplete list.
_autocomplete() {
    local cur=${COMP_WORDS[COMP_CWORD]};
    local opts="$(eval $1)";
    COMPREPLY=( $(compgen -W "$opts" -- $cur) );
}
# Given the name of a target function and a evaluable string generating an autocomplete list,
# creates a new function to handle the autocomplete with the list being genererated on each
# autocomplete call.
make_autocomplete() {
    local target_fn="$1"
    local autocomplete_fn="_$1"
    curry $autocomplete_fn _autocomplete "$2"
    complete -F $autocomplete_fn $target_fn
}

ssh-add -K

alias npm-exec='PATH=$(npm bin):$PATH'

coinmon() {
    curl -s "https://api.coinmarketcap.com/v1/ticker/$1/?convert=$2" | jq ".[0] .price_$2"
}
