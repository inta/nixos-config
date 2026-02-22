{ config, lib, pkgs, ... }:
let
  username = lib.baseNameOf ./.;
in
{
  users.users.${username} = {
    isNormalUser = true;
  };

  home-manager.users.${username} = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = config.system.stateVersion;
    programs.home-manager.enable = true;

    imports = [
      ../../home/shell
      ../../home/browser
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            caffeine.extensionUuid
            docker.extensionUuid
            quake-terminal.extensionUuid
          ];
        };
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    };

    programs.git = {
      enable = true;
      settings.user = {
        name = "Christoph";
        email = "christoph@intanet.de";
      };
    };

    home.file = {
      ".local/bin/tmux-sessionizr.sh" = {
        text = ''
          #!/usr/bin/env bash

          if [ $# -eq 1 ]; then
          	selected=$1
          else
          	mark_active_tmux_session='name=$(echo $0 | sed s/^.*\\/Projects\\///); \
          		if tmux has-session -t="$name" 2> /dev/null; then echo $0 \*; else echo $0; fi'
          	selected=$(fd --min-depth 1 --max-depth 2 --type d . ~/Projects -x sh -c "$mark_active_tmux_session" |
          		sk --keep-right --reverse --delimiter=/ --nth=5..)
          	if [ $? -gt 0 ]; then exit; fi
          fi

          # remove asterisk marking opened tmux sessions
          selected=$(echo "$selected" | rg '(\s\*)?$' -r ''')

          # remove path prefix and trailing slash
          selected_name=$(echo "$selected" | rg "^$HOME/(?:Projects/)?" -r ''' | rg '/?$' -r ''' | rg '\.?' -r ''')

          if ! tmux has-session -t="$selected_name" 2> /dev/null; then
          	tmux new-session -ds "$selected_name" -c "$selected" -n hx
          	tmux send-keys -t "$selected_name":hx 'hx' C-m
          	tmux new-window -t "$selected_name" -c "$selected" -d -n lazygit
          	tmux send-keys -t "$selected_name":lazygit 'lazygit' C-m
          fi

          if [ -z "$TMUX" ]; then
          	tmux attach-session -t "$selected_name"
          else
          	tmux switch-client -t "$selected_name"
          fi
        '';
        executable = true;
      };
    };
  };
}
