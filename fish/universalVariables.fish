#!/usr/bin/env fish

set -U fish_greeting ""
set -Ux RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc
set -Ux DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -U fisher_path $XDG_DATA_HOME/fisher

# bobthefish
set -U theme_display_date no
set -Ux VIRTUAL_ENV_DISABLE_PROMPT 1

