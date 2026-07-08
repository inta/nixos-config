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

    virtualisation.docker.enable = true;

    services.gitea-actions-runner = {
        package = pkgs.forgejo-runner;
        instances.default = {
            enable = true;
            name = "forgejo-runner";
            url = "https://code.datenhalde.net";
            # register manually: Site Administration > Actions > Runners > Create new Runner,
            # then put "TOKEN=<value>" into this file
            tokenFile = "/etc/nixos/forgejo-runner-token";
            labels = [
                "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
                "docker:docker://docker:cli"
            ];
            # mount the host docker socket into job containers so `docker build` works
            settings.container.docker_host = "automount";
        };
    };
}
