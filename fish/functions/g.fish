function g --wrap git
    if [ -z "$argv" -o "$argv[1]" = "--" ]
        git status $argv
    else if [ "$argv[1]" = "-" ]
        git switch -
    else
        git $argv
    end
end

