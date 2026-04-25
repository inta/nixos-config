{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  system.stateVersion = "25.11";

  environment.systemPackages = [
    pkgs.vim
  ];

  networking.firewall.allowedTCPPorts = [ 8443 ];

  nixpkgs.config.allowUnfree = true;

  services.unifi = {
    enable = true;
    openFirewall = true;
    unifiPackage = pkgs.unifi;
    mongodbPackage = pkgs.mongodb-ce;
  };
}
