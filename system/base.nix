{ pkgs, ... }:

{
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    # instant deduplication on nix store write
    nix.settings.auto-optimise-store = true;

    # automatic deduplication by timer (not really needed if auto-optimise above is enabled)
    # nix.optimise.automatic = true;
    
    # automatic garbage collection for nix store
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 7d";
}
