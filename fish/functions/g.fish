set _GIT (nvl -c hub git)

function g --wrap $_GIT
    if [ -z "$argv" -o "$argv[1]" = "--" ]
        $_GIT status $argv
    else if [ "$argv[1]" = "-" ]
        $_GIT switch $argv
    else if [ "$argv[1]" = "addi" ]
        ga $argv[2..]
    else
        $_GIT $argv
    end
end

