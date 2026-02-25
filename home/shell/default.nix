{ pkgs, ... }:

{
    imports = [
        # ./common.nix
        # ./starship.nix
        ./alacritty.nix
        ./fish.nix
        ./nu.nix
        ./tmux.nix
    ];

    home.packages = with pkgs; [
        eza
        bat
        skim
        ripgrep
        fd
        delta
        # tokei
        # hyperfine
        # dust
        # diskonaut
        # procs
        # rustscan
        # record-query
        # sd
        # shellharden
        # xcp
        # xh
        # zellij
        # zoxide
        htop
        btop
        # bottom
        # iotop
        # iftop
    ];

    # add environment variables
    home.sessionVariables = {
        # clean up ~
        # LESSHISTFILE = cache + "/less/history";
        # LESSKEY = c + "/less/lesskey";
        # WINEPREFIX = d + "/wine";

        # set default applications
        EDITOR = "nvim";
        TERMINAL = "alacritty";

        # enable scrolling in git diff
        DELTA_PAGER = "less -R";

        # MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
}
