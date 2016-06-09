#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# PS1='\u@\h:\w '
# PS1='[\u@\h \W]\$ '
# PS1=">\[\033[s\]\[\033[1;\$((COLUMNS-5))f\]\$(date +%H:%M)\[\033[u\]"
# PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
# PS1="\n\n\[\e[1;36m\]________________________________________________________________ [\w] \$(date +%H:%M)\[\e[0m\]\n\n--->  "
# PS1="\n\n\[\e[1;36m\]\$(date +%H:%M) [\w]\[\e[0m\]\n\n--->  "
PS1="\n\[\e[30;1m\]\$(date +%H:%M) [\w]\n\n--->\[\e[0m\] $ "
# PS1="\n\[\e[30;1m\]\$(printf '%0.s-' \$(seq 1 \$(expr $COLUMNS - $((`pwd|wc -c`))))) [\w]\n\n--->\[\e[0m\] "
# PS1="\n\[\e[30;1m\]\$(printf '%0.s-' \$(seq 1 \$(expr $COLUMNS - 21))) [\w]\n\n--->\[\e[0m\] "

#printf '%0.s-' $(seq 1 $(expr $COLUMNS - $((`pwd|wc -c`))))

# set the PATH environment
PATH=$PATH:$HOME/bin; export PATH

#==================================================
# ALIASES
#==================================================
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
# -> Prevents accidentally clobbering files
alias mkdir='mkdir -p'

alias h='history'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
#alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ls -R'           #  Recursive ls.
alias la='ls -A'           #  Show hidden files.
alias lf='ls -F'
alias lla='ll -A'
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

#-------------------------------------------------------------
# Pacman alias examples
#-------------------------------------------------------------
alias pacupg='sudo pacman -Syu'        # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database

# Additional pacman alias examples
alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

#-------------------------------------------------------------
# Start X server
#-------------------------------------------------------------
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
