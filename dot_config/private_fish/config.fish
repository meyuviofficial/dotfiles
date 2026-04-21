if status is-interactive
    # Commands to run in interactive sessions can go here
    # catppuccin_tide mocha rainbow

    # set vi mode
    fish_vi_key_bindings

    # fzf config
    fzf --fish | source

    # backward kill a word
    # bind alt-backspace backward-kill-word
    bind -M insert alt-backspace backward-kill-word

    # Append path variable
    fish_add_path --append $HOME/go/bin
    fish_add_path --append /opt/homebrew/bin
    fish_add_path --append '/Applications/Visual Studio Code.app/Contents/Resources/app/bin'
    fish_add_path --append /Users/ys/.local/bin

    # zoxide config
    zoxide init fish | source

    # Initialize Starship prompt
    starship init fish | source

    # Universal variables
    set -Ux XDG_CONFIG_HOME "$HOME/.config"
    set -Ux HOMEBREW_CASK_OPTS "--appdir=~/Applications"

    # Global variables
    set -gx NODE_EXTRA_CA_CERTS ~/.config/certs/zscaler.pem
end
