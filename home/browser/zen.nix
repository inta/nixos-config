{ inputs, pkgs, ... }:

{
    imports = [ inputs.zen-browser.homeModules.default ];

    programs.zen-browser = {
        enable = true;

        policies = {
            DontCheckDefaultBrowser = true;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DisableTelemetry = true;
            # AutofillAddressEnabled = true;
            # AutofillCreditCardEnabled = false;
            # DisableAppUpdate = true;
            # DisableFeedbackCommands = true;
            # DisableFirefoxStudies = true;
            # DisablePocket = true;
            # NoDefaultBookmarks = true;
            # OfferToSaveLogins = false;
            # EnableTrackingProtection = {
            #     Value = true;
            #     Locked = true;
            #     Cryptomining = true;
            #     Fingerprinting = true;
            # };
        };

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

            settings = {
                "extensions.autoDisableScopes" = 0;

                "zen.welcome-screen.seen" = true;
                "zen.tabs.show-newtab-vertical" = false;
                "zen.view.use-single-toolbar" = false;
                "zen.view.sidebar-expanded" = false;

                "intl.accept_languages" = "de,en-us,en";
                "browser.translations.neverTranslateLanguages" = "en,de";

                # Does not work reliably, so do not use it for now
                # "browser.uiCustomization.state" = "";
            };

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
                        definedAliases = [ "s" ];
                    };
                };
            };
        };
    };
}
