# Only display short path in prompt.
PROMPT='%(5~|%-1~/…/%3~|%4~) %# '

# Path.
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/scripts"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/go/bin"

# History.
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

# Activate zsh completion system.
autoload -U +X compinit && compinit

# Source kubectl zsh completion.
source <(kubectl completion zsh)

# Source plugin manager.
source "$ZDOTDIR/plugin-management.zsh"

# Source plugins/config.
[[ -f ". /opt/homebrew/opt/asdf/asdf.sh" ]] && . "/opt/homebrew/opt/asdf/asdf.sh"
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
zsh_source_file "plugins/fzf.sh"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Source exports.
zsh_source_file "exports.zsh"
zsh_source_file "exports.private.zsh"

# Source functions.
zsh_source_file "funcs.zsh"

# Source aliases.
zsh_source_file "aliases.zsh"

# Key bindings.
[[ -f "$HOME/.local/scripts/tmux-sessionizer" ]] && bindkey -s ^f "^utmux-sessionizer\n"
