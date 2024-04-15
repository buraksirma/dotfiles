#!/usr/bin/env fish

function yabu -d "Updates and restarts yabai"
    yabai --uninstall-service
    brew upgrade yabai

    echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

    yabai --start-service
end
