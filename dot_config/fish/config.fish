status is-login; and begin

    # Login shell initialisation
    # fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /run/current-system/sw/bin

    set -U FZF_LEGACY_KEYBINDINGS 0
    set -U FZF_DISABLE_KEYBINDINGS 1
    set -U $FZF_DEFAULT_OPTS "--color bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4,header:#f38ba8,hl:#f38ba8,hl+:#f38ba8,info:#cba6f7,marker:#f5e0dc,pointer:#f5e0dc,prompt:#cba6f7,spinner:#f5e0dc"
end

status is-interactive; and begin
    # Abbreviations
    abbr --add -- grep rg
    abbr --add -- man batman
    abbr --add -- untar 'tar -xvf'

    # Aliases
    alias cat bat
    alias la 'eza -a'
    alias ll 'eza --all --long --grid --header --no-filesize --no-time --no-user --git --icons'
    alias lla 'eza -la'
    alias ls eza
    alias tree 'eza --tree --icons --all --git-ignore --ignore-glob=.git'

    # Interactive shell initialisation
    fzf --fish | source
    # /nix/store/8xafvgyqh8v45s2ivpjh26i332ih2692-fzf-0.66.1/bin/fzf --fish | source

    bind \ck up-or-search
    bind \cj down-or-search
    bind \ch backward-char
    bind \cl forward-char
    bind \cs beginning-of-line
    bind \ce end-of-line

    if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end

    if test "$TERM" != dumb
        # /nix/store/rpcz0blydcyqmji56c82mvkh9jkk51bb-starship-1.24.0/bin/starship init fish | source
        starship init fish | source
    end

    mise activate fish | source
    # /nix/store/hbmy51vsi92c0bfcgp2w8cy7cx1hqs93-mise-2025.9.10/bin/mise activate fish | source

    if set -q GHOSTTY_RESOURCES_DIR
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    end


    # /nix/store/4amf2iq54jfn3pnwm6li47sa96v8nps0-atuin-18.8.0/bin/atuin init fish --disable-up-arrow | source
    atuin init fish --disable-up-arrow | source

    # /nix/store/7jfl43irizm04l5qwyfqd6wbc919fimb-direnv-2.37.1/bin/direnv hook fish | source
end
