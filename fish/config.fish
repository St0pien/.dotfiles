if status is-interactive
    fish_vi_key_bindings

    export GPG_TTY=$(tty)

    # <C-K> for autocomplete
    bind -M normal \v forward-char
    bind -M insert \v forward-char

    # tmux sessionizer
    export REPOS=~/repos
    set -x REPOS ~/repos
    alias r="~/repos/.dotfiles/shcripts/repofinder.sh"
    bind -M normal \cF r
    bind -M insert \cF r
    alias t="~/repos/.dotfiles/shcripts/tmuxfinder.sh"
    bind -M normal \cT t
    bind -M insert \cT t

    # turn off truncation
    set fish_prompt_pwd_dir_length 0
end
