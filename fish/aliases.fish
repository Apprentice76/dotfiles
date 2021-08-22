# function timezsh
#   shell ${1-$SHELL}
#   # shell zsh
#   for i in $(seq 1 10); do time $shell exit; done
# end
function e
  set val (functions --no-details $argv[1] | egrep '\-\-wraps=(\')?' | sed -E 's/--wraps\=\'?/--wraps=\'/' | sed -E 's/\'? --description/\' --description/' | cut -d\' -f2)
  # echo $val
  functions -e $argv[1] && $argv[1] $argv[2..-1]
  alias $argv[1] $val
end

function vc
	cd -P -- "$argv[1]" &&
	code "$argv[1..2]" &&
	cd -
end

function md
  mkdir -p -- "$argv[1]" &&
  cd -P -- "$argv[1]"
end

function gcc
	git checkout $argv[1] .
end

function push
  git push origin HEAD:$argv[1]
end

function gbrd
  git push origin :$argv[1]
end

function gcmf
  git commit -m "$argv"
end

function gacf
  git add -A && git commit -m "$argv"
end

function staf
  git stash apply stash@{$argv[1]}
end

function stpf
  git stash pop stash@{$argv[1]}
end

function stdf
  git stash drop stash@{$argv[1]}
end

function sthf
  git stash -u && git stash apply
end

function sthmf
  git stash save -u "$argv" && stash apply
end

function stmf
  git stash save "$argv"
end

function stumf
  git stash save -u "$argv"
end

# Default to human readable figures
alias df 'df -h'
alias du 'du -h'
# Interactive operation...
# alias rm 'rm -i'
# Some shortcuts for different directory listings
alias ls 'ls -hNF --color'                 	# classify files in colour
alias ll 'ls -l'                           	# long list
alias llx 'll -X'                          	# long list, sorted by ext
alias llu 'll -U'				# long list, sorted by name
alias lls 'll -Sr'                         	# long list, sorted by size
alias la 'ls -A'				# long list all
alias lsp 'ls ..'
alias mkdir 'mkdir -p'
# Custom
alias alsyn 'cat ~/.zsh/.zsh_aliases > ~/.bash/.bash_aliases'
alias su 'sudo'
alias rm 'Recycle'
alias jsvr 'json-server'
#alias vim 'nvim'
alias vi 'vim'
alias clr 'clear'
alias x 'exit'
alias cra 'create-react-app'
alias _ 'cd -'
alias .. 'cd ..'
alias ... 'cd ../..'
alias apt 'apt-cyg'
alias conf 'vim ~/.config/fish/config.fish'
alias confa 'vim ~/.config/fish/aliases.fish'
alias confh 'vim ~/.local/share/fish/fish_history'
alias confm 'vim ~/.minttyrc'
alias confv 'vim ~/_vimrc'
# Git commands
alias gf 'git fetch'                                # fetch upstream
alias gc 'git clone'                                # clone git repo
alias gp 'git push'                                 # push to repo
alias gpu 'gp -u'                                     # push to & set upstream
alias gpl 'git pull'                                # fetch & merge
alias gcm 'git commit -m'                           # commit changes
alias gca 'git commit -am'                            # stage modified files & commit
alias ga 'git add'                                  # move to staging
alias gaa 'ga -A'                                     # stage modified & new files
alias gat 'ga .'                                      # stage modified files
alias gac 'gaa && gcm'                                  # stage modified & new files then commit
alias gcp 'gac && gp'                                   # stage modified & new files then commit then push to upstream
alias gch 'git checkout'					                  # switch to existing branch
                                                    # for checking out commits, use: git checkout `commit_id` .
alias gcb 'gch -b'                                    # create new branch then switch to it
alias gb 'git branch'                               # view local branches
alias gbr 'gb -r'                                     # view remote branches
alias gba 'gb -a'                                     # view all branches
alias gbm 'gb -m'                                     # move/rename branch
alias gbd 'gb -d'                                     # delete merged branch
alias gbD 'gb -D'                                     # force delete branch
alias gbu 'gb -u'                                     # set branch upstream
alias gmc 'git merge'                               # merge (after fetch)
alias gm 'git merge --no-commit'                      # merge without committing
alias gr 'git remote'                               # remote commands
alias grv 'gr -v'                                     # view remotes
alias grs 'gr set-url'                                # set given url with given remote name 
alias gra 'gr add'                                    # add new remote with its url
alias grd 'gr remove'                                 # remove remote
alias grr 'gr rename'                                 # rename remote
alias gs 'git status'                               # view current modifications
alias gld 'git log'                                 # commit/stash history
alias gl 'gld --oneline'                              # short history
alias gut 'git rm -r --cached'                      # untrack files from git
alias gin 'git init'                                # initialize git
alias auh 'gpl --allow-unrelated-histories' 				# only to be used when pulling from new empty remote repo
alias dif 'git diff'                                # diff b/w two branches
alias sth 'git stash'                               # stash file modifications
alias stm 'sth save'                                  # save stash with message($argv[1])
alias stu 'sth -u'                                    # stash untracked files also
alias stum 'sth save -u'                              # give message($argv[1]) to stash with untracked files also
alias sta 'sth apply'                                 # apply stash@{`id`}, default most recent
alias stp 'sth pop'                                   # apply stash@{`id`} and delete from stack, default most recent
alias stl 'sth list'                                  # list of stashes
alias sts 'sth show'                                  # diff b/w current branch and stash
alias stsd 'sth show -p'                              # detailed diff
alias stb 'sth branch'                                # create branch with some name($argv[1]) from stash@{`id`}($2)
alias std 'sth drop'                                  # drop stash@{`id`}
alias stc 'sth clear'                                 # drop all stashes
alias gsr 'git reset --soft'                        # reset to commit id($argv[1]) only, no change in index or WD
alias gmr 'git reset --mixed'                       # reset to commit id($argv[1]), clear staging area, i.e, files (modified & new) removed from index
alias ghr 'git reset --hard'                        # reset to commit id($argv[1]), clear working directory & staging area too
alias grbi 'git rebase'                             # rebase
alias grb 'grbi -i'                                   # rebase - interactive
alias grbr 'grb --root'                               # rebase from root
alias grbc 'grbi --continue'                          # rebase continue
alias grba 'grbi --abort'                             # rebase abort
alias rfl 'git reflog'                              # command history
alias acm 'git commit --amend -m'                   # amend most recent commit message
# NPM commands
alias npr 'npm run'
alias npi 'npm install'
alias npd 'npi --save-dev'
alias nps 'npm start'
alias npu 'npm uninstall'
alias npb 'npr build'
# Yarn commands
alias ya 'yarn add'
alias yg 'yarn global'
alias yga 'yg add'
alias yad 'ya --dev'
alias yrm 'yarn remove'
alias yi 'yarn install'
alias yl 'yarn list'
alias ys 'yarn start'
alias yb 'yarn build'
alias yr 'yarn run'
alias yu 'yarn upgrade'
alias ycra 'yarn create react-app'
