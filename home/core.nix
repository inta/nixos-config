{ osConfig, username, ... }: 

{
  imports = [
    ./shell
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = osConfig.system.stateVersion;
  };
}
