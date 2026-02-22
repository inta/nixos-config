{ pkgs, ... }: {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    caffeine
    docker
    quake-terminal
  ];
}
