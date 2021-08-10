vc ()
{
	cd -P -- "$1" &&
	code "${@:2}" &&
	cd -
}
md ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Default to human readable figures
alias df='df -h'
alias du='du -h'
# Interactive operation...
# alias rm='rm -i'
# Some shortcuts for different directory listings
alias ls='ls -hNF --color'                 # classify files in colour
alias ll='ls -l'                           # long list
alias llx='ll -X'                          # long list, sorted by ext
alias lls='ll -Sr'                         # long list, sorted by size
alias la='ls -A'
alias lsp='ls ../'
alias mkdir='mkdir -p'
# Custom
alias alsyn='cat ~/.zsh/.zsh_aliases > ~/.bash/.bash_aliases'
alias su='sudo'
alias rm='Recycle'
alias jsvr='json-server'
alias vi='vim'
alias clr='clear'
alias x='exit'
alias X='x'
# Git commands
alias gc='git clone'
alias gp='git push'
alias gpu='gp -u'
alias gpl='git pull'
alias gcm='git commit -m'
alias gca='git commit -am'
alias ga='git add'
alias gaa='ga -A'
alias gat='ga .'
alias gac='gaa && gcm'
alias gcp='gac && gp'
alias gch='git checkout'
alias gcb='gch -b'
alias gb='git branch'
alias gbr='gb -r'
alias gba='gb -a'
alias gbd='gb -d'
alias gbu='gb -u'
alias gm='git merge'
alias gr='git remote'
alias grv='gr -v'
alias grs='gr set-url'
alias gra='gr add'
alias grd='gr remove'
alias grr='gr rename'
alias gs='git status'
alias gl='git log'
alias auh='--allow-unrelated-histories'
# NPM commands
alias npr='npm run'
alias npi='npm install'
alias nps='npm start'
# Yarn commands
alias ya='yarn add'
alias yga='yarn global add'
alias yad='yarn add --dev'
alias yrm='yarn remove'
alias yi='yarn install'
alias yl='yarn list'
alias ys='yarn start'
alias yb='yarn build'
alias yr='yarn run'