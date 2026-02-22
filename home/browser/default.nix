{ pkgs, config, ... }: 

{
  imports = [
    ./firefox.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # set default applications
    BROWSER = "firefox";
  };
}
