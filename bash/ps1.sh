# PS1 configuration
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=yes
    fi
fi

# show user and host when connected by SSH
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    if [ "$color_prompt" = yes ]; then
        userhost="\[\033[01;32m\]\u\[\033[00m\]@\[\033[1;34m\]\h\[\033[00m\]:"
    else
        userhost="\u@\h:"
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}'${userhost}'\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}'${userhost}'\w$(__git_ps1)$ '
fi
unset userhost
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
