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

    services.forgejo-runner.instances.default = {
        enable = true;
        settings = {
            # uuid and token come from the runner registration (Site Administration > Actions > Runners);
            # the token file holds the bare token, without a "TOKEN=" prefix
            server.connections.default = {
                url = "https://code.datenhalde.net";
                uuid = "6c3251e0-e35a-4c08-8d92-9689f189f04a";
            };
            runner.labels = [
                "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
                "docker:docker://docker:cli"
            ];
            # mount the host docker socket into job containers so `docker build` works
            container.docker_host = "automount";
        };
        secrets.server.connections.default.token_url = "/etc/nixos/forgejo-runner-token";
    };
}
