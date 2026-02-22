{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser= {
    enable = true;
    profiles.default = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
        darkreader
        # Firefox Multi-Account Containers?
        # multi-account-containers
        # User-Agent Switcher and Manager?
        # user-agent-string-switcher
        # Key Jump keyboard navigation alphanumeric? alternative: link hints?
        # linkhints
      ];
      search = {
        force = true;
        default = "brave";
        engines = {
          brave = {
            name = "Brave Search";
            urls = [
              {
                template = "https://search.brave.com/search?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
            definedAliases = ["s"];
          };
        };
      };
    };
    suppressXdgMigrationWarning = true;
  };
}
