{ ... }:

{
    imports = [
        ./firefox.nix
        ./zen.nix
        ./brave.nix
    ];

    # add environment variables
    home.sessionVariables = {
        # set default applications
        BROWSER = "zen-beta";
    };
}
