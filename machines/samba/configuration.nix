{
    pkgs,
    modulesPath,
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

    # shared group for everyone allowed to write into the shares
    users.groups.share = { };

    # system users are the samba users; they have no login password,
    # the smb password is set manually once: smbpasswd -a cs
    users.users.cs = {
        isNormalUser = true;
        home = "/srv/home/cs";
        extraGroups = [ "share" ];
    };

    systemd.tmpfiles.rules = [
        "d /srv/home 0755 root root -"
        "d /srv/share 2770 root share -"
    ];

    services.samba = {
        enable = true;
        openFirewall = true;
        settings = {
            global = {
                "workgroup" = "WORKGROUP";
                "server string" = "samba";
                "security" = "user";
                "map to guest" = "never";
                "server min protocol" = "SMB3";
            };

            share = {
                path = "/srv/share";
                comment = "shared files";
                browseable = "yes";
                "read only" = "no";
                "valid users" = "@share";
                "force group" = "share";
                "create mask" = "0660";
                "directory mask" = "2770";
            };

            homes = {
                comment = "home directories";
                browseable = "no";
                "read only" = "no";
                "valid users" = "%S";
                "create mask" = "0600";
                "directory mask" = "0700";
            };
        };
    };

    # makes the server show up in the windows explorer network view
    services.samba-wsdd = {
        enable = true;
        openFirewall = true;
    };
}
