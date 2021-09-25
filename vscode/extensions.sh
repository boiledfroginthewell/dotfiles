#!/bin/bash

code --list-extensions | xargs -L 1 echo code --install-extension

code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag
code --install-extension Gruntfuggly.todo-tree
code --install-extension kamikillerto.vscode-colorize
code --install-extension Orta.vscode-jest
code --install-extension saikou9901.evilinspector
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension tranhl.find-then-jump
code --install-extension usernamehw.errorlens

