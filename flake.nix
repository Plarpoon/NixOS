{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    username = "plarpoon";
    stateVersion = "23.11";
  in {
    nixosConfigurations = {
      bjorn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bjorn/configuration.nix
          home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./hosts/bjorn/home.nix;
            system.stateVersion = stateVersion;
          })
        ];
        specialArgs = { inherit inputs username stateVersion; };
      };

      daisy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/daisy/configuration.nix
          home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./hosts/daisy/home.nix;
            system.stateVersion = stateVersion;
          })
        ];
        specialArgs = { inherit inputs username stateVersion; };
      };
    };
  };
}
