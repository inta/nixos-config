{ pkgs, modulesPath, config, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  system.stateVersion = "25.11";

  environment.systemPackages = [
    pkgs.vim
  ];

  security.acme.defaults.email = "cert@intanet.de";
  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.immich = {
    enable = true;
    mediaLocation = "/var/lib/immich";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
  
    virtualHosts."immich.datenhalde.net" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://[::1]:${toString config.services.immich.port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
        extraConfig = ''
          client_max_body_size 50000M;
          proxy_read_timeout   600s;
          proxy_send_timeout   600s;
          send_timeout         600s;
        '';
      };
    };
  };
}
