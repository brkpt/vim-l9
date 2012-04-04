# base-files version 3.7-1

# To pick up the latest recommended .bashrc content,
# look in /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file
#~ set -x
if [ -n "$PS1" ]; then
	echo .bashrc
fi

export EDITOR=vim
export VISUAL=vim
export CYGWIN='nodosfilewarning codepage:oem binmode title glob:ignorecase'
export HISTCONTROL=ignoredups
export INPUTRC=$HOME/.inputrc

# Shell Options
# #############

# See man bash for more options...

# Don't wait for job termination notification
set -o notify

# Don't use ^D to exit
#set -o ignoreeof

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Make bash check for misspelled path names
shopt -s cdspell

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell


# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
case $- in
	*i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
esac


# History Options
# ###############

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Let the history grow!
export HISTFILESIZE=
export HISTSIZE=

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
#alias df='df -h'
#alias du='du -h'

# Misc :)
alias cdr='cd ~'
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='/usr/bin/grep --color'                     # show differences in colour
alias open='cygstart'
alias px='cygstart c:/pstools/procexp'

#--- Some useful utility aliases
alias luaplus='${LuaPlusExe64}'
alias levelmem='${LuaPlusExe64} ${PROJECT_ROOT}/${GameName}/Scripts/levelmem.lua'
alias dumpcho='${LuaPlusExe64} ${PROJECT_ROOT}/${GameName}/Scripts/dumpcho.lua'
alias actordump='${LuaPlusExe64} ${PROJECT_ROOT}/${GameName}/Scripts/actordump.lua'
#alias c:='c:/cygdrive/c'
#alias vi='vim'
#alias cls='clear'

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias lla='ls -la'

function favs() {
	history | awk '{print $2}' | sort | uniq -c | sort -nr | less
}

# Dircolors
###########
eval "`dircolors -b ~/.dircolors`"

# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

# pipe commands through less
function so {
eval "$@" | less -I~
}

# Winmerge
function wm {
	local wmpath="${PROGRAMFILES}/Winmerge/Winmergeu.exe"

	if [ $# -eq 0 ]; then
		cygstart "${wmpath}"
	else
		local firstpath=$(cygpath -wa "${1}")
		local secondpath=$(cygpath -wa "${2}")
		cygstart "${wmpath}" "${firstpath}" "${secondpath}"
	fi
}


# Source a ~/.contextrc file if it exists
#~ if [ -a ~/.contextrc ]; then
	#~ source ~/.contextrc
#~ fi

# Prompts
###########

#PS1='\u@\h:\W\$ '
#PS1='\[\e[0;\w\a\]  \n  \[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
#PS1='\[\e[0m\]\n[\[\e[33;40m\]\w]\[\e[0m\]\n\$ '
#PS1='`cygpath -w \w`> '
#PS1='\[\e[0m\]\n[\[\e[33m\]\[\e[1m\]\w\[\e[0m\]]\n\$ '

# Happy face
#PS1="\`if [ \$? = 0 ]; then echo \[\e[33m\]^_^\[\e[0m\]; else echo \[\e[31m\]O_O\[\e[0m\]; fi\`[\u@\h:\w]\\$ "

# Color code result
#PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'

# Multiline
# This one is a multi-line prompt containing date/time, full path, user and host, active terminal, even file count and space usage.
#PS1="\n\[\033[35m\]\$(/bin/date)\n\[\033[32m\]\w\n\[\033[1;31m\]\u@\h: \[\033[1;34m\]\$(/usr/bin/tty | /bin/sed -e 's:/dev/::'): \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[0m\] -> \[\033[0m\]"

#provides time, username, hostname, and current directory. Fairly minimal but useful.
#PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#full path at the first line and pretty much just the username at the bottom.
#PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"

#The first line is the normal user@host, with full path. On the second line we’ve got history number and a count of the jobs running in the background.
#PS1='\[\e[1;32m\]\u@\H:\[\e[m\] \[\e[1;37m\]\w\[\e[m\]\n\[\e[1;33m\]hist:\! \[\e[0;33m\] \[\e[1;31m\]jobs:\j \$\[\e[m\] '

#With this one we’ve got user/host, number of jobs, and date/time on the top line. Below that is current directory along with number of files in that directory and their disk usage.
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"

#It’s a modification of #7, changed to take up less space and include only the information I most want in my prompt. I like the two-line style as it lets me see the full path without reducing the space for my actual commands.
#PS1="\n\[\e[32;1m\](\[\e[37;1m\]\u\[\e[32;1m\])-(\[\e[37;1m\]jobs:\j\[\e[32;1m\])-(\[\e[37;1m\]\w\[\e[32;1m\])\n(\[\[\e[37;1m\]! \!\[\e[32;1m\])-> \[\e[0m\]"

# git prompt
#~ PS1='\[\e[0m\]\n[\[\e[33m\]\[\e[1m\]\w\[\e[0m\]]\[\e[37m\]
#~ $(__git_ps1 "(%s)")\[\e[1;37m\]\$ '

#~ basename `dirname \`dirname \\\`getndenv | cut -f2 | sed -e 's/\"//g'\\\`\``
#~ PS1='\[\e[0m\]\n[\[\e[33m\]\[\e[1m\]\w\[\e[0m\]]\[\e[37m\]
#~ ($(__dvdroot)$(__git_ps1 ":%s"))\[\e[1;37m\]\$ '

# Finalize
##########
# Put current directory on the path
export PATH=.:${PATH}

# Source in the git completion script
export GITDIR=$(cygpath "${PROGRAMFILES}/git")
#alias gitk='"${GITDIR}/cmd/gitk.cmd"'
#alias gg='"${GITDIR}/cmd/git.cmd" gui'

programfiles=$(cygpath -u "${PROGRAMFILES}")
if [ -e "${programfiles}/git/etc/git-completion.bash" ]; then
	. "${programfiles}/git/etc/git-completion.bash"
fi
#~ [ -r /opt/local/share/git-completion.bash ] && . /opt/local/share/git-completion.bash

function carsfinal () { genv d:/dev-cars-finalwii/main/cars ; }

# Source a ~/.contextrc file if it exists
if [ -a ~/.contextrc ]; then
	source ~/.contextrc
fi

cdr
