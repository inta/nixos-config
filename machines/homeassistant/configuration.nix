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
  security.acme.defaults.email = "cert@intanet.de";

  # DNS-01 via INWX must be set per-cert: enableACME forces HTTP-01 (webroot) and
  # dnsProvider is NOT inherited from defaults. Define the cert here and point
  # nginx at it with useACMEHost — no inbound ports needed, works VPN/LAN-only.
  security.acme.certs."homeassistant.datenhalde.net" = {
    dnsProvider = "inwx";
    environmentFile = "/etc/nixos/inwx.env";
    group = "nginx";
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
      useACMEHost = "homeassistant.datenhalde.net";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;
      };
    };
  };
}
