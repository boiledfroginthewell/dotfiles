not status -i || status -c && exit
[ ! -e "/etc/arch-release" ] && exit

alias task go-task
alias ss "yay -Slq | fzf --multi --preview 'yay -Si {1}'"
