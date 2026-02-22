{ config, inputs, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    # extensions = [
    #   {
    #     name = "ublock-origin";
    #     url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    #   }
    #   {
    #     name = "bitwarden";
    #     url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    #   }
    #   {
    #     name = "darkreader";
    #     url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
    #   }
    #   {
    #     name = "user-agent-switcher";
    #     url = "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
    #   }
    #   {
    #     name = "keyjump";
    #     url = "https://addons.mozilla.org/firefox/downloads/latest/key-jump/latest.xpi";
    #   }
    # ];
    # profiles.default = {};
    profiles.default.extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
      ublock-origin
      bitwarden
      darkreader
    ];
  };
}
