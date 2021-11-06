# System
alias rm="rm -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias l="exa"
alias la="exa -a"
alias ll="exa -lah"
alias ls="exa --color=auto"

# Neovim
#alias nvim="lvim"

# zsh
alias srczshrc="source $HOME/.config/zsh/.zshrc"
alias zshrc="$EDITOR $HOME/.config/zsh/.zshrc"

# tmux
alias ta="tmux attach"

# Python
alias python="python3"

# Git
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# Lua language server
alias luamake="$HOME/.local/share/lua-language-server/3rd/luamake/luamake"

# Kubernetes
alias k="kubectl"
complete -F __start_kubectl k

# Tree
alias tree="tree -aFC --dirsfirst -I .git"
