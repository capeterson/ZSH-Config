zstyle ':completion:*' completer _expand _complete _correct
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '~/.zshrc'
#zmodload -i zsh/complist	#Color completion
setopt AUTO_CD			#cd if if your command is just a folder name
setopt CDABLE_VARS
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
#setopt MENUCOMPLETE
#setopt sharehistory
setopt prompt_subst

autoload -Uz compinit
autoload colors
colors
compinit
HISTFILE=~/.histfile
HISTSIZE=300
SAVEHIST=300

#Set some evn variables
export PAGER=less
export EDITOR=vim
export PATH=$PATH:/opt/local/sbin/:/opt/local/bin/:~/bin/:/opt/subversion/bin

source ~/.alias
source ~/.functions

 
bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

loadAgent()

#Create dirs that other stuff expects
if [ ! -d ~/logs ]; then
	mkdir ~/logs
fi

# set a simple variable to show when in screen
    if [[ -n "${WINDOW}" ]]; then
        SCREEN=" S:${WINDOW}"
    else
        SCREEN=""
    fi

#Init colors
for COLOR in RED GREEN YELLOW WHITE BLACK; do
	eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
	eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{$reset_color%}"


#Create cars that stuff expects to exist
export shelltime=`date -u +%s`

#listsysctls () { set -A reply $(sysctl -AN ${1%.*}) }
#	compctl -K listsysctls sysctl
#Enable stalker mode
watch=(notme) #tell me any time somebody else logs in
LOGCHECK=15 
WATCHFMT='%n %a %l from %m at %t.'
export PS1="%(?..-=%?=-)[%n@%U${PR_GREEN}%m%u${PR_RESET}]%(1j.+%j.){%~} "

function precmd
{
	local TERMWIDTH
	(( TERMWIDTH = ${COLUMNS} - 1 ))
}
