{ inputs, pkgs, ... }:

{
    imports = [ inputs.zen-browser.homeModules.default ];

    programs.zen-browser = {
        enable = true;

        policies = {
            DisableFirstRun = true;
            DontCheckDefaultBrowser = true;
            #     AutofillAddressEnabled = true;
            #     AutofillCreditCardEnabled = false;
            #     DisableAppUpdate = true;
            #     DisableFeedbackCommands = true;
            #     DisableFirefoxStudies = true;
            #     DisablePocket = true;
            #     DisableTelemetry = true;
            #     DontCheckDefaultBrowser = true;
            #     NoDefaultBookmarks = true;
            #     OfferToSaveLogins = false;
            #     EnableTrackingProtection = {
            #         Value = true;
            #         Locked = true;
            #         Cryptomining = true;
            #         Fingerprinting = true;
            #     };
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
                zen.tabs.show-newtab-vertical = false;
                zen.view.use-single-toolbar = false;
                zen.view.sidebar-expanded = false;
                browser.uiCustomization.state = {
                    placements = {
                        widget-overflow-fixed-list = [ ];
                        zen-sidebar-top-buttons = [ "zen-toggle-compact-mode" ];
                        zen-sidebar-foot-buttons = [
                            "downloads-button"
                            "zen-workspaces-button"
                            "zen-create-new-button"
                        ];
                        nav-bar = [
                            "back-button"
                            "forward-button"
                            "stop-reload-button"
                            "vertical-spacer"
                            "urlbar-container"
                            "unified-extensions-button"
                            "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                            "ublock0_raymondhill_net-browser-action"
                            "addon_darkreader_org-browser-action"
                        ];
                        toolbar-menubar = [ "menubar-items" ];
                        TabsToolbar = [ "tabbrowser-tabs" ];
                        vertical-tabs = [ ];
                        PersonalToolbar = [ "personal-bookmarks" ];
                        unified-extensions-area = [ ];
                    };
                    seen = [
                        "addon_darkreader_org-browser-action"
                        "ublock0_raymondhill_net-browser-action"
                        "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                        "developer-button"
                        "screenshot-button"
                    ];
                    dirtyAreaCache = [
                        "unified-extensions-area"
                        "nav-bar"
                    ];
                    currentVersion = 23;
                    newElementCount = 5;
                };
                intl.accept_languages = "de,en-us,en";
                browser.translations.neverTranslateLanguages = "en,de";
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

        suppressXdgMigrationWarning = true;
    };
}
