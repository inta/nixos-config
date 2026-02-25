{ pkgs, ... }:

{
    imports = [
        ./helix.nix
    ];

    home.packages = with pkgs; [
        meld
    ];
}
