{ pkgs, ... }:

{
    imports = [
        # ./nushell
        # ./common.nix
        # ./starship.nix
        ./alacritty.nix
        ./fish.nix
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
        meld
    ];

    # add environment variables
    home.sessionVariables = {
        # clean up ~
        # LESSHISTFILE = cache + "/less/history";
        # LESSKEY = c + "/less/lesskey";
        # WINEPREFIX = d + "/wine";

        # set default applications
        EDITOR = "nvim";
        BROWSER = "firefox";
        TERMINAL = "alacritty";

        # enable scrolling in git diff
        DELTA_PAGER = "less -R";

        # MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
}
