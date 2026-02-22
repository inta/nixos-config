{ pkgs, config, ... }: 

{
  imports = [
    ./firefox.nix
    ./zen.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # set default applications
    BROWSER = "firefox";
  };
}
