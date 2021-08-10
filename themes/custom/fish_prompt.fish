set __slavic_color_orange FD971F
set __slavic_color_blue 6EC9DD
set __slavic_color_green A6E22E
set __slavic_color_yellow E6DB7E
set __slavic_color_pink F92672
set __slavic_color_grey 554F48
set __slavic_color_white F1F1F1
set __slavic_color_purple 9458FF
set __slavic_color_lilac AE81FF
set __custom_green 00C884
set __custom_blue 96CBFD
set __custom_orange D48128
set __custom_indigo 9372ED #FF8C00 dark orange, FFA500 orange, another one fa0 o
    
# function _icons_initialize
    set -g ICON_VCS_UNTRACKED '?'
    set -g ICON_VCS_UNMERGED '~'
    set -g ICON_VCS_MODIFIED '!'
    set -g ICON_VCS_STAGED '+'
    set -g ICON_VCS_DELETED d
    set -g ICON_VCS_DIFF "↔"
    set -g ICON_VCS_RENAME -
    set -g ICON_VCS_STASH "*"
    set -g ICON_VCS_INCOMING_CHANGES "⇣"
    set -g ICON_VCS_OUTGOING_CHANGES "⇡"
    set -g ICON_VCS_TAG "◎"
    set -g ICON_VCS_BOOKMARK "◉"
    set -g ICON_VCS_COMMIT "▲"
    set -g ICON_VCS_BRANCH
    set -g ICON_VCS_REMOTE_BRANCH "→"
    set -g ICON_VCS_DETACHED_BRANCH
    set -g ICON_VCS_GIT
    set -g ICON_VCS_HG
    set -g ICON_VCS_CLEAN
    set -g ICON_VCS_PUSH # bugs out in fish: \UF005 (printf "\UF005")
    set -g ICON_VCS_DIRTY "∙"
    set -g ICON_ARROW_UP "↑"
    set -g ICON_ARROW_DOWN "↓"
    set -g ICON_OK "✓"
    set -g ICON_FAIL x
    set -g ICON_STAR
    set -g ICON_JOBS
    set -g ICON_VIM
# end

function _col #Set Color 'name b u' bold, underline
    set -l col
    set -l bold
    set -l under
    if [ -n "$argv[1]" ]
        set col $argv[1]
    end
    if [ (count $argv) -gt 1 ]
        set bold "-"(string replace b o $argv[2] 2>/dev/null)
    end
    if [ (count $argv) -gt 2 ]
        set under "-"$argv[3]
    end
    set_color $bold $under $argv[1]
end
function _col_res -d "Rest background and foreground colors"
    set_color -b normal
    set_color normal
end

function _git_ahead_verbose -d 'Print a more verbose ahead/behind state for the current branch'
    set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2> /dev/null)
    if [ $status != 0 ]
        return
    end
    set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
    set -l ahead (count (for arg in $commits; echo $arg; end | grep -v '^<'))
    switch "$ahead $behind"
        case ''    # no upstream
        case '0 0' # equal to upstream
            return
        case '* 0' # ahead of upstream
            echo (_col green)"$ICON_VCS_OUTGOING_CHANGES$ahead"
        case '0 *' # behind upstream
            echo (_col green)"$ICON_VCS_INCOMING_CHANGES$behind"
        case '*' # diverged from upstream
            echo (_col green)"$ICON_VCS_INCOMING_CHANGES$ahead"(_col green)"$ICON_VCS_OUTGOING_CHANGES$behind"
    end
end

function _git_ahead -d 'Print the ahead/behind state for the current branch'
    if [ "$theme_display_git_ahead_verbose" = yes ]
        _git_ahead_verbose
        return
    end
    command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null | awk '/>/ {a += 1} /</ {b += 1} {if (a > 0 && b > 0) nextfile} END {if (a > 0 && b > 0) print "⇕"; else if (a > 0) print ""; else if (b > 0) print ""}' #↑↓⇕⬍↕
end

function _is_git_folder -d "Check if current folder is a git folder"
    git status 1>/dev/null 2>/dev/null
end

function _git_branch -d "Display the current git state"
    set -l ref
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set ref (command git symbolic-ref HEAD 2>/dev/null)
        if [ $status -gt 0 ]
            set -l branch (command git show-ref --head -s --abbrev | head -n1 2>/dev/null)
            set ref " $ICON_VCS_DETACHED_BRANCH$branch"
        end
        set -l branch (echo $ref | sed "s-refs/heads/--")
        echo " "(_col magenta)"$branch "(_col_res)
    end
end

function _is_git_dirty -d 'Check if branch is dirty'
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null) #'-s' short format
end

function _git_status -d 'Check git status'
    set -l space ' '
    set -l nospace ''
    if [ (command git stash list 2> /dev/null| wc -l) -gt 0 ] #stashed (was '$')
        set -l stashed (command git stash list 2> /dev/null| wc -l)
        echo -n (_col brred)$nospace$ICON_VCS_STASH$stashed$space
    end
    set -l git_status (command git status --porcelain 2> /dev/null | cut -c 1-2)
    set -l ahead (_git_ahead_verbose)
    echo -n $ahead$space
    if [ (echo -sn $git_status\n | egrep -c ".[MT]") -gt 0 ] #modified
        set -l modified (command git diff --name-only 2> /dev/null | wc -l)
        echo -n (_col $__custom_indigo)$nospace$ICON_VCS_MODIFIED$modified
    end
    if [ (echo -sn $git_status\n | egrep -c "[ACDMT][ MT]|[ACMT]D") -gt 0 ]
        set -l staged (command git status --porcelain 2> /dev/null | cut -c 1-2 | egrep -c "[ACDMT][ MT]|[ACMT]D")
        echo -n (_col $__custom_orange)$nospace$ICON_VCS_STAGED$staged
    end
    #set -l staged  (command git diff --cached --no-ext-diff --quiet --exit-code; or echo -n '~')      #was '~'
    if [ (echo -sn $git_status\n | egrep -c "\?\?") -gt 0 ] #untracked (new) files
        set -l untracked (command git ls-files . --exclude-standard --others 2> /dev/null| wc -l)
        echo -n (_col brcyan)$nospace$ICON_VCS_UNTRACKED$untracked
    end
    if [ (echo -sn $git_status\n | egrep -c "D") -gt 0 ] #deleted
        set -l deleted (command git status --porcelain 2> /dev/null | cut -c 1-2 | egrep -c "D")
        echo -n (_col red)$nospace$ICON_VCS_DELETED$deleted
    end
    if [ (echo -sn $git_status\n | egrep -c "R.") -gt 0 ] #renamed
        set -l renamed (echo -sn $git_status\n | egrep -c "R.")
        echo -n (_col green)$nospace$ICON_VCS_RENAME$renamed
    end
    if [ (echo -sn $git_status\n | egrep -c "AA|DD|U.|.U") -gt 0 ] #unmerged
        set -l unmerged (echo -sn $git_status\n | egrep -c "AA|DD|U.|.U")
        echo -n (_col brred)$nospace$ICON_VCS_UNMERGED$unmerged(_col_res)
    end


    #set -l untracked ''
    #set -l show_untracked (git config --bool bash.showUntrackedFiles)
    #if [ "$theme_display_git_untracked" != 'no' -a "$show_untracked" != 'false' ]
    #  set untracked (command git ls-files --other --exclude-standard --directory --no-empty-directory)
    #  if [ "$untracked" ]
    #    set untracked $ICON_VCS_UNTRACKED           #was …
    #  end
    #end
    echo ''
    #echo -n $added\n$deleted\n$modified\n$renamed\n$unmerged\n$untracked
end

function _prompt_git -a current_dir -d 'Display the actual git state'
    set -l dirty (command git diff --no-ext-diff --quiet --exit-code; or echo -n ' ')
    set -l flag_fg (_col brgreen)
    if [ "$dirty" -o "$staged" ] # if either dirty or staged
        set flag_fg (_col yellow)
    else if [ "$stashed" ]
        set flag_fg (_col brred)
    end
    echo -n -s $flag_fg(_git_branch)(_git_status)(_col_res) #add space if dirty to separate from icons "$dirty"
end

function __slavic_color_echo
    set_color $argv[1]
    if test (count $argv) -eq 2
        echo -n $argv[2]
    end
end

function __slavic_current_folder
    if test $PWD = /
        echo -n /
    else
        echo -n $PWD | grep -o -E '[^\/]+$'
    end
end


# function fish_mode_prompt
#   set_color $__slavic_color_lilac
#   printf '['
#   switch $fish_bind_mode
#     case default
#       set_color red
#       printf 'n'
#     case insert
#       set_color green
#       printf 'i'
#     case visual
#       set_color magenta
#       printf 'v'
#   end
#   set_color $__slavic_color_lilac
#   printf '] '
# end

function fish_right_prompt
    
end

function fish_prompt
    # _icons_initialize
    set -g last_status $status
    __slavic_color_echo $__custom_blue (prompt_pwd)
    # __slavic_git_status
    _is_git_folder; and _prompt_git
    echo
    if test $last_status = 0
        __slavic_color_echo $__slavic_color_purple "❯ "
    else
        __slavic_color_echo $__slavic_color_pink "❯ "
    end
end
