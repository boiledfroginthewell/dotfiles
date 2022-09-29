function g --wrap git
    if [ -z "$argv" -o "$argv[1]" = "--" ]
        git status $argv
    else if [ "$argv[1]" = "-" ]
        git switch $argv
    else if [ "$argv[1]" = "addi" ]
        ga $argv[2..]
    else
        git $argv
    end
end

