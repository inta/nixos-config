{
  description = "A noobs flake, do not trust it";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: let
    machineNames = builtins.attrNames (builtins.readDir ./machines);
  in {
    nixosConfigurations = builtins.listToAttrs (builtins.map (name: {
      name = name;
      value = import ./machines/${name}/system.nix { inherit nixpkgs home-manager inputs; };
    }) machineNames);
  };
}
