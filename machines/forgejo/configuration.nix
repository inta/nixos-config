{
    pkgs,
    modulesPath,
    config,
    lib,
    ...
}:

{
    imports = [
        (modulesPath + "/virtualisation/proxmox-lxc.nix")
        ../../system/base.nix
    ];

    system.stateVersion = "26.05";

    environment.systemPackages = [
        pkgs.vim
    ];

    security.acme.defaults.email = "cert@intanet.de";
    security.acme.acceptTerms = true;

    networking.firewall.allowedTCPPorts = [
        80
        443
    ];

    services.forgejo = {
        enable = true;
        database.type = "postgres";
        lfs.enable = true;
        settings = {
            server = {
                DOMAIN = "code.datenhalde.net";
                ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}/";
                HTTP_PORT = 3000;
                SSH_PORT = builtins.head config.services.openssh.ports;
            };
            service.DISABLE_REGISTRATION = true;
            actions = {
                ENABLED = true;
                DEFAULT_ACTIONS_URL = "github";
            };
            mailer = {
                ENABLED = true;
                SMTP_ADDR = "mail.datenhalde.net";
                FROM = "noreply@datenhalde.net";
                USER = "noreply@datenhalde.net";
            };
        };
        secrets.mailer.PASSWD = "/etc/nixos/forgejo-mailer-password";
        # secrets.mailer.PASSWD = config.age.secrets.forgejo-mailer-password.path;
    };

    systemd.services.forgejo.preStart =
        let
            adminCmd = "${lib.getExe config.services.forgejo.package} admin user";
            pwd = "/etc/nixos/forgejo-admin-password";
            user = "christoph"; # Note, Forgejo doesn't allow creation of an account named "admin"
            email = "christoph@datenhalde.net";
        in
        ''
            ${adminCmd} create --admin --email ${email} --username ${user} --password "$(tr -d '\n' < ${pwd})" || true
            ## uncomment this line to change an admin user which was already created
            # ${adminCmd} change-password --username ${user} --password "$(tr -d '\n' < ${pwd})" || true
        '';

    # age.secrets.forgejo-mailer-password = {
    #   file = ../secrets/forgejo-mailer-password.age;
    #   mode = "400";
    #   owner = "forgejo";
    # };

    services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;

        virtualHosts.${config.services.forgejo.settings.server.DOMAIN} = {
            enableACME = true;
            forceSSL = true;
            locations."/" = {
                proxyPass = "http://localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}";
                proxyWebsockets = true;
                extraConfig = ''
                    client_max_body_size 512M;
                '';
            };
        };
    };
}
