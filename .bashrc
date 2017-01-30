# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Load tmux on startup with Base session
if [[ -f ~/.tmux_on_startup ]] && \
    command -v tmux > /dev/null && \
    [[ ! $TERM =~ screen ]] && \
    [[ -z $TMUX ]]
then
    # Ensure existence of directory for continuum plugin (tmux.service)
    mkdir -p ~/.config/systemd/user

    # Reattach to existing tmux session or create new one
    tmux attach -t Base || tmux new -s Base
fi

# Set terminal title through xterm control sequence
echo -ne "\e]0;$(hostname)\a"

# Source global definitions
if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
fi

# Enable bash completion in interactive shells
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Source fzf.bash for fuzzy search
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Export localization variables
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Shell options
shopt -s globstar
shopt -s checkwinsize

# Navigation
shopt -s autocd
alias cd..='cd ..'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../../'
alias .4='cd ../../../..'
alias -- -="cd -"

# Various
alias h='history'
alias j='jobs -l'
alias ll='ls -alh --color=auto'
alias ls='ls --color=auto'
alias mkdir='mkdir -p'
alias cl='clear'
alias v='vim'
alias clipkey='cat ~/.ssh/id_rsa.pub > /dev/clipboard'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias less='less -r'
alias vagrantsup='vagrant up && vagrant ssh'
alias ag='ag --color --pager "less -RF"'

# History
history -a
shopt -s histappend
export HISTFILESIZE=1000000
export HISTSIZE=100000
export HISTCONTROL=ignorespace
export HISTIGNORE='ls:history:ll'
export HISTTIMEFORMAT='%d-%m-%Y %T '

# Git
# Create g<alias> shortcuts for all git aliases and enable git autocompletion
function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_func && __git_complete g$al $complete_func
done

# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$_";
}

# Customize prompt PS1
my_prompt() {
    local branch=$(git branch 2>/dev/null | grep '^*' | sed s/..//)
    local branch_addition=""

    if [ -n "$branch" ]
    then
        branch_addition=" [\[\e[38;5;202m\]${branch}\[\e[0m\]]"
    fi

    export PS1="\u@\h:\[\e[38;5;57m\]\w\[\e[0m\]${branch_addition} \\$ "
}

PROMPT_COMMAND=my_prompt

# List bash aliases
la() {
    # Currently all my aliases are in .bashrc
    grep "^alias" ~/.bashrc  | cut -c 7- | sort
}

# Generate a random password
randpasswd() {
    tr -dc a-zA-Z0-9 < /dev/urandom | head -c${1:-32}; echo 1>&2;
}

# Test for the presence of the sshgo socket file
# and export the SSH_AUTH_SOCK environmental if not already set.
SSHGO_SOCK_FILE=~/.ssh_auth_sock
if [[ -S $SSHGO_SOCK_FILE && -z "$SSH_AUTH_SOCK" ]]; then
    export SSH_AUTH_SOCK=$SSHGO_SOCK_FILE
fi

# Shortcut function to start ssh-agent
# with a predictable SSH_AUTH_SOCK location add add keys
sshgo() {
    if [ -S $SSHGO_SOCK_FILE ]; then
        echo "ssh-agent is already running";
    else
        eval $(ssh-agent -a $SSHGO_SOCK_FILE) && ssh-add
    fi
}

foreachgit() {
    local cmd=$1
    local path=${2:-$(pwd)}
    local cwd=$(pwd)

    local git_paths=$(find $path -name '.git' -print0 | xargs --null -n 1 dirname)

    for git_path in $git_paths
    do
        echo "Entering GIT repository: '$git_path'"
        cd "$git_path"
        echo "Executing: '$cmd'"
        eval "$cmd"
    done

    cd $cwd
}

# Function to show the given function arguments and visualize word splitting
showargs() {
    printf "%d args:" $#
    printf " <%s>" "$@"
    echo
}
