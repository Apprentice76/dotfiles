# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${HOME}/.cache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${HOME}/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_AUTOSUGGEST_STRATEGY=(
match_prev_cmd
completion
history
)

source ~/.zsh/.zsh_aliases
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# source ~/.zsh/.inputrc

# if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${HOME}/.zcompdump) ]; then
#  compinit
# else
#  compinit -C
# fi

setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=1000
SAVEHIST=10000
HISTCONTROL=ignoreboth:ignorespace
HISTORY_IGNORE='(jobs *|zpty *|ps *|conf)'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

function chpwd() {
    print -Pn "\e]0;zsh %~\a" 2>/dev/null
}
function zshaddhistory() {
    emulate -L zsh
    if [[ $1 != ("zpty"|"np"*|^"y"..?|*"sh"|"kill"*|"source"*|"tree"*|"history"|"conf"|"jobs"|"ps"*|"g"..?) ]] ; then
        print -sr -- "${1%%$'\n'}"
        fc -p
    else
        return 1
    fi
}

export PATH="$PATH:/c/Users/Hp/AppData/Local/Yarn"
print -Pn "\e]0;zsh %~\a" 2>/dev/null

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=magenta"
autoload -Uz compinit && compinit
autoload -Uz clean && clean &!
zmodload zsh/zpty && zpty &!

# case $TERM in
#   xterm*)
#     print -Pn "\e]0;zsh %~\a" 2>/dev/null
#     ;;
#   *)
# esac
# clear
