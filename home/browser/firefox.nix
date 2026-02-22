{ inputs, pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        profiles.default.extensions.packages =
            with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                ublock-origin
                bitwarden
                darkreader
            ];
    };
}
