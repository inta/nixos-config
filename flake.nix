{
  description = "A noobs flake, do not trust it";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
