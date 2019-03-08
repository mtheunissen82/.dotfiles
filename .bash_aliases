# Navigation
shopt -s autocd
alias cd..='cd ..'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../../'
alias .4='cd ../../../..'
alias -- -="cd -"

# Bookmark
alias bm='bookmark_cd_fzf' # list bookmarks
alias bms='bookmark_set_cwd' # bookmark set
alias bmu='bookmark_unset_cwd' # bookmark unset

# Bash
alias lrc='source ~/.bashrc' # load rc
alias erc='vim ~/.bashrc; source ~/.bashrc' # edit rc

# Various
alias h='history'
alias j='jobs -l'
alias ll='ls -alh --color=auto'
alias ls='ls --color=auto'
alias mkdir='mkdir -p'
alias cl='clear'
alias clipkey='cat ~/.ssh/id_rsa.pub | xclip -selection clipboard'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias less='less -r'
alias vagrantsup='vagrant up && vagrant ssh'
alias ag='ag --color --pager "less -RF"'
alias stat='stat -c "%n %A (%a) %U %G %s"'

# Docker
alias dex='docker exec'
alias dexit='docker exec --interactive --tty'
alias di='docker inspect'
alias dc='docker-compose'

# Networking
alias ils='ip link show'
alias ias='ip addr show'
alias iptables='sudo iptables --list --line-numbers --verbose'
alias route='route -n'

# Apt
alias apti='apt_install_fzf'
alias aptr='apt_remove_fzf'
