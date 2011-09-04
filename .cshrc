############################################################
# cshrc - script to start a csh session
# Michael Wardle, April 24, 2003
############################################################

# read local settings (company environment, network, etc.)
if ( -r ~/.cshrc.local ) then
	source ~/.cshrc.local
endif

# set command aliases

alias l		"ls -s"
alias l.	"ls -d .*"
alias ll	"ls -l"
alias latest	"ls -t | head"

# settings for all sessions
setenv CVS_RSH ssh
setenv PATH ${PATH}:/home/essadmin/

# settings for interactive sessions
if ( $?prompt ) then
	# set preferred programs
	which less >& /dev/null
	if ( $status == 0 ) then
		setenv PAGER less
	endif
	which vim >& /dev/null
	if ( $status == 0 ) then
		setenv VISUAL vim
	endif

	# set program configuration variables
	if ( -r ~/.vimrc ) then
		setenv VIMINIT "source ~/.vimrc"
	endif
	if ( -r ~/.inputrc ) then
		setenv INPUTRC ~/.inputrc
	endif
	setenv CLICOLOR
	setenv LESS eiMqX
	if ( $?TABSIZE ) then
		setenv LESS "${LESS}x${TABSIZE}" 
	endif
	setenv WINTERM xterm

	set color
	set filec
	if ( $?tcsh ) then
		# set options
		set addsuffix
		set autoexpand
		set autolist
		set complete
		set correct=cmd
		set ellipsis
		set listjobs
		set visiblebell

		# set key bindings
		#bindkey -e
		bindkey -v
		bindkey -k up		history-search-backward
		bindkey -k down		history-search-forward
		bindkey [3~		delete-char

		# set command completions
		complete {,un}alias	'p/1/a/' 'p/2/c/'
		complete {c,push,pop}d	'C/*/d/'
		complete exec		'p/1/c/'
		complete man		'C/*/c/'
		complete {where,which}	'C/*/c/'
		complete {,un}set	'p/1/s/'
		complete {,un}setenv	'C/*/e/'
		complete printenv	'C/*/e/'
		complete showenv	'p/1/e/'
		complete bindkey	'p/1/b/'
		complete fg		'c/%/j/'
		complete kill		'c/%/j/' 'c/-/S/'
		complete chgrp		'p/1/g/'
		complete chown		'p/1/u/'
		complete limit		'C/*/l/'
		complete find		'p/1/d/' 'n/-user/u/' 'n/-group/g/'
	endif

	# set some prompt variables
	setenv HOSTNAME `hostname`
	setenv USER `id -nu`
	setenv TTY `tty`

	# set the prompt format
	if ( $?tcsh ) then
        	alias set_prompt 'set prompt="%m:%c%# "'
	else
		if ( `id -u` == 0 ) then
			alias set_prompt 'set prompt="${HOSTNAME}# "'
		else
			alias set_prompt 'set prompt="${HOSTNAME}> "'
		endif
		alias cd 'cd \!*; set_prompt'
		alias pushd 'pushd \!*; set_prompt'
		alias popd 'popd \!*; set_prompt'
	endif
	set_prompt

	# set the title
	if ( $?term && $?tcsh ) then
		switch ( $term )
        	case "xterm*":
		case "rxvt":
		case "dtterm":
			alias set_title 'echo -n "]2;\!*"'
			alias set_icontitle 'echo -n "]1;\!*"'
			breaksw
		case "iris-ansi":
			alias set_title 'echo -n "P1.y\!*\\"'
			alias set_icontitle 'echo -n "P3.y\!*\\"'
			breaksw
		default:
			alias set_title 'echo -n "\!*" > /dev/null'
			alias set_icontitle 'echo -n "\!*" > /dev/null'
			breaksw
		endsw
		if ( $?PROJECT_ID ) then
			alias precmd 'set_title "${LOGNAME}@${HOSTNAME:ar}\<${TTY:t}\>\(${PROJECT_ID}\):${PWD}"; set_icontitle "${HOSTNAME:ar}\<${TTY:t}\>"'
		else
			alias precmd 'set_title "${LOGNAME}@${HOSTNAME:ar}\<${TTY:t}\>:${PWD}"; set_icontitle "${HOSTNAME:ar}\<${TTY:t}\>"'
		endif
	endif
endif

