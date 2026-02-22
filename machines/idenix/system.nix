{ home-manager, inputs, nixpkgs }:
nixpkgs.lib.nixosSystem {
  # specialArgs = {inherit inputs;};
  system = "x86_64-linux";
  modules = [
    home-manager.nixosModules.default
    ./configuration.nix
    # home-manager.nixosModules.home-manager
    # {
    #   home-manager.useGlobalPkgs = true;
    #   home-manager.useUserPackages = true;
    #   home-manager.users.jdoe = ./home.nix;

    #   # Optionally, use home-manager.extraSpecialArgs to pass
    #   # arguments to home.nix
    # }
  ];
}
