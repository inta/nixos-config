{ config, pkgs, ... }:

{
    programs.alacritty = {
        enable = true;
        settings = {
            keyboard.bindings = [
                {
                    action = "Quit";
                    key = "Q";
                    mods = "Control";
                }
            ];
            window.dimensions = {
                columns = 150;
                lines = 50;
            };
            # scrolling.history = 10000;
        };
    };

    xdg = {
        desktopEntries = {
            quakelacritty = {
                name = "Quakelacritty";
                genericName = "Quake-like Terminal Emulator";
                type = "Application";
                exec = "alacritty --class Quakelacritty --config-file ${config.xdg.configHome}/alacritty/quakelacritty.toml";
                icon = "Alacritty";
                terminal = false;
                categories = [
                    "System"
                    "TerminalEmulator"
                ];
                settings = {
                    StartupWMClass = "Quakelacritty";
                };
            };

            tmuxalacritty = {
                name = "Tmuxalacritty";
                genericName = "Tmux/Alacritty context switcher";
                type = "Application";
                exec = "alacritty --class Tmuxalacritty --config-file ${config.xdg.configHome}/alacritty/tmuxalacritty.toml";
                icon = "Alacritty";
                terminal = false;
                categories = [
                    "System"
                    "TerminalEmulator"
                ];
                settings = {
                    StartupWMClass = "Tmuxalacritty";
                };
            };
        };

        configFile."alacritty/quakelacritty.toml".text = ''
            [[keyboard.bindings]]
            action = "Quit"
            key = "Q"
            mods = "Control"

            [terminal.shell]
            args = ["-L", "quake", "new-session", "-As", "quake"]
            program = "${pkgs.tmux}/bin/tmux"

            [window]
            decorations = "none"
            opacity = 0.95
        '';

        configFile."alacritty/tmuxalacritty.toml".text = ''
            [[keyboard.bindings]]
            action = "Quit"
            key = "Q"
            mods = "Control"

            [terminal.shell]
            args = ["-l", "-c", "tmux attach || tmux-sessionizr"]
            program = "${pkgs.fish}/bin/fish"

            [window]
            title = "Tmuxalacritty"

            [window.dimensions]
            columns = 150
            lines = 50
        '';
    };
}
