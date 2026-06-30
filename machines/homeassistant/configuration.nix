{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../system/base.nix
  ];

  system.stateVersion = "26.05";

  environment.systemPackages = [
    pkgs.vim
  ];

  security.acme.acceptTerms = true;
  security.acme.defaults = {
    email = "cert@intanet.de";
    # DNS-01 via INWX (no inbound ports needed, works behind WireGuard/LAN only)
    dnsProvider = "inwx";
    environmentFile = "/etc/nixos/inwx.env";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.home-assistant = {
    enable = true;
    extraComponents = [
      "default_config"
      "met"
      "esphome"
    ];
    config = {
      default_config = { };
      http = {
        server_host = "127.0.0.1";
        use_x_forwarded_for = true;
        trusted_proxies = [ "127.0.0.1" ];
      };
    };
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."homeassistant.datenhalde.net" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;
      };
    };
  };
}
