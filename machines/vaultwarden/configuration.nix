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

  services.vaultwarden = {
    enable = true;
    backupDir = "/srv/backup";
    environmentFile = "/etc/nixos/vaultwarden.env";
    config = {
      #ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      DOMAIN = "https://vaultwarden.datenhalde.net";
      # LOG_FILE = "/var/log/vaultwarden";
      SIGNUPS_ALLOWED = false;
      SIGNUPS_VERIFY = true;
      #ADMIN_TOKEN = "<see env file>";
      SMTP_HOST = "mail.datenhalde.net";
      SMTP_FROM = "noreply@datenhalde.net";
      SMTP_FROM_NAME = "Vaultwarden (Datenhalde)";
      SMTP_PORT = 587;
      SMTP_SECURITY = "starttls";
      SMTP_USERNAME = "noreply@datenhalde.net";
      #SMTP_PASSWORD = "<see env file>";
      #SMTP_TIMEOUT = 15;
    };
  };

  services.nginx = {
    enable = true;
    
    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."vaultwarden.datenhalde.net" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
        proxyWebsockets = true;
      };
    };
  };
}
