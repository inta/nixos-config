{ pkgs, modulesPath, config, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../system/base.nix
  ];

  system.stateVersion = "24.05";

  environment.systemPackages = [
    pkgs.vim
  ];

  security.acme.defaults.email = "cert@intanet.de";
  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nextcloud = {
    package = pkgs.nextcloud33;
    hostName = "nextcloud.datenhalde.net";
    home = "/srv/nextcloud";
    enable = true;
    https = true;
    configureRedis = true;
    caching.redis = true;
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = "/etc/nixos/nextcloud-admin-pass";
    };
    autoUpdateApps.enable = true;
    maxUploadSize = "1G";
    notify_push.enable = true;
    # notify_push.bendDomainToLocalhost = true;
    settings = {
      trusted_proxies = ["192.168.192.1"];
      default_phone_region = "DE";
      default_timezone = "Europe/Berlin";
      maintenance_window_start = 1;
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
    phpOptions = {
      "opcache.interned_strings_buffer" = "64";
    };
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    enableACME = true;
    forceSSL = true;
  };
}
