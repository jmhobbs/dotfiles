PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# some more aliases
alias cls='clear'

#alias grep='grep -n'

export PATH="$PATH:/home/jmhobbs/System/bin"

calc(){ awk "BEGIN{ print $* }" ;}

#source $HOME/System/opt/Bash-Git-Prompt/git_remote_check.sh
#source $HOME/System/opt/Bash-Git-Prompt/git_prompt.sh
