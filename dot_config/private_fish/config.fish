if status is-interactive
    # Commands to run in interactive sessions can go here
end

catppuccin_tide mocha rainbow

# set vi mode
fish_vi_key_bindings

# fzf config
fzf --fish | source

# backward kill a word
# bind alt-backspace backward-kill-word
bind -M insert alt-backspace backward-kill-word

# Append path variable
fish_add_path --append $HOME/go/bin

# zoxide config
zoxide init fish | source

# Initialize Starship prompt
# starship init fish | source
