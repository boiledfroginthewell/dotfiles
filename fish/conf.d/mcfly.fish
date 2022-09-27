not status -i || status -c && exit

set -gx MCFLY_INTERFACE_VIEW BOTTOM
mcfly init fish | source

