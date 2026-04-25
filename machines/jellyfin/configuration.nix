{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  system.stateVersion = "25.05";

  environment.systemPackages = [
    pkgs.vim
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  networking.firewall.allowedTCPPorts = [ 80 ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    virtualHosts."jellyfin.datenhalde.net" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_buffering off;
        '';
      };
    };
  };
}
