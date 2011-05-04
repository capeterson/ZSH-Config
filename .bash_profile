export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export TERM=xterm
export PATH=$PATH:~/bin/:~/bin/scripts:/opt/local/sbin/:/opt/local/bin/
export EDITOR=vim
export PAGER=less
export PS1="[\u@\h]{\w} "	
export MANPATH=/opt/local/share/man:$MANPATH

cd ~
source .alias

#Start ssh-agent, import keys by hand because screw typing my passphrase at every shell
if [ -f ~/.ssh/.agent ]; then
	source ~/.ssh/.agent
fi
if [ ! -e $SSH_AUTH_SOCK ]; then
	echo "agent is dead, starting a new one..."
	ssh-agent > ~/.ssh/.agent
	source ~/.ssh/.agent
	ssh-add
fi

if [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi

#enable SSH completions
SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | egrep -v [0123456789]) )
complete -o default -W "${SSH_COMPLETE[*]}" ssh
