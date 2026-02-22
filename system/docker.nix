{ pkgs, ... }:

{
  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;

      daemon.settings = {
        default-address-pools = [
          {
            base = "172.27.0.0/16";
            size = 24;
          }
        ];
      };
    };
  };
}
