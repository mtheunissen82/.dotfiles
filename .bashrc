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
    source /etc/bashrc
fi

# Source aliases
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

# Source bash completion
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Source fzf.bash for fuzzy search
if [[ -f ~/.fzf.bash ]]; then
    source ~/.fzf.bash
fi

source ~/.dotfiles/bash_functions.d/util

# Export localization variables
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Shell options
shopt -s globstar
shopt -s checkwinsize

# History
history -a
shopt -s histappend
export HISTFILESIZE=1000000
export HISTSIZE=100000
export HISTCONTROL=ignorespace
export HISTIGNORE='ls:history:ll'
export HISTTIMEFORMAT='%d-%m-%Y %T '

# Less
export LESS="-IRFX"

# Git
# Create g<alias> shortcuts for all git aliases and enable git autocompletion
for al in $(__git_get_config_variables "alias"); do
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
    local yellow1="\[\e[38;5;226m\]"
    local deepskyblue1="\[\e[38;5;39m\]"
    local orangered1="\[\e[38;5;202m\]"
    local grey54="\[\e[38;5;245m\]"
    local reset="\[\e[0m\]"

    local bookmark_addition=""
    bookmark_check_cwd
    if [[ $? -eq 0 ]]; then
        bookmark_addition=" 📖"
    fi

    local branch=$(git branch 2>/dev/null | grep '^*' | sed s/..//)
    local branch_addition=""

    if [ -n "$branch" ]
    then
        branch_addition=" ${grey54}⦗${orangered1}${branch}${grey54}⦘"
    fi

    export PS1="\n${deepskyblue1}\w${bookmark_addition}${branch_addition}${reset}\n ${yellow1}⮕ ${reset} "
}

PROMPT_COMMAND=my_prompt

# List bash aliases
la() {
    # Currently all my aliases are in .bashrc
    grep "^alias" ~/.bash_aliases  | cut -c 7- | sort
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

git_compare_branches() {
    local lhs_branch=${1:-''}
    local rhs_branch=${2:-''}
    local dotspec='..'

    # If the function input contains double or triple dot notation, parse branches accordingly.
    # Double dot notation is used by default if no dotspec is given
    dots_list="... .."
    for dots in $dots_list; do
        if [[ "$@" == *$dots* ]]; then
            local spec_spaced=$(tr "$dots" "\n" <<< "$@")
            local spec_arr=($spec_spaced)

            lhs_branch="${spec_arr[0]}"
            rhs_branch="${spec_arr[1]}"
            dotspec="$dots"

            break
        fi
    done

    local rev_list=$(git rev-list --no-merges --left-right "${lhs_branch}${dotspec}${rhs_branch}")
    local rev_count=$(git rev-list --no-merges --left-right --count "${lhs_branch}${dotspec}${rhs_branch}")
    local rev_count_arr=($rev_count)

    if [[ ${rev_count_arr[0]} -gt 0 ]]; then
        echo "${rev_count_arr[0]} commit(s) in ${lhs_branch} (not present in ${rhs_branch})"
        echo "$rev_list" | grep '^<' | tr -d '<'
        echo
    fi

    if [[ ${rev_count_arr[1]} -gt 0 ]]; then
        echo "${rev_count_arr[1]} commit(s) in ${rhs_branch} (not present in ${lhs_branch})"
        echo "$rev_list" | grep '^>' | tr -d '>'
        echo
    fi
}

# Checkout git branch with fzf
fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
        fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Function to show the given function arguments and visualize word splitting
showargs() {
    printf "%d args:" $#
    printf " <%s>" "$@"
    echo
}

cert_fingerprint() {
    local cmd='openssl x509 -noout -fingerprint'
    local input_cert=$1
    local hash_algo=${2:-'sha1'}

    cmd=$cmd" -$hash_algo"
    cmd=$cmd" -in $input_cert"

    $cmd | sed 's/.*Fingerprint=//'
}

cert_url_fetch() {
    local host=$1
    local port=${2:-443}

    openssl s_client -servername ${host} -connect ${host}:${port} </dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
}

# Overwrite the cd builtin with a custom function which writes all cd navigated
# paths as absolute paths to ~/.cd_history
cd() {
    local cd_args="$@"
    local path=""

    # remove "-- " prefix
    cd_args=${cd_args#-- }

    # short-circuit special case -
    if [[ $cd_args = "-" ]]; then
        command cd -
        return
    fi

    if [[ -z $cd_args ]]; then
        path=~
    elif [[ $cd_args = /* ]]; then
        path=$cd_args
    else
        path=$(realpath "$(pwd)/$cd_args")
    fi

    # if path exists add to .cd_history
    if [[ -d $path ]]; then
        echo $path >> ~/.cd_history
    fi

    command cd "$path"
}

# Custom fzf history function
fzf_cd_history() {
    dir=$(cat ~/.cd_history | fzf --tac --height 40%) && printf 'cd %q' "$dir"
}

# Custom readline bindings
# fzf shortcut to custom "cd" functionality
bind '"\ec": " \C-e\C-u`fzf_cd_history`\e\C-e\er\C-m"'
# easy "less" piping shortcut
bind '"\C-l": " \C-e | less\e\C-e\er\C-m"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
