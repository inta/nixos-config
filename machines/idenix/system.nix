{ home-manager, inputs, nixpkgs }:
nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs;};
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
  ];
}
