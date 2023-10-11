{
  # Define the inputs for the flake
  inputs = {
    # The Nix Packages collection, which contains packages for the Nix package manager
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager, a user environment manager for Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      # Make the home-manager flake follow the nixpkgs flake
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Define the outputs for the flake
  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        # Define a NixOS configuration for the 'bjorn' host
        bjorn = nixpkgs.lib.nixosSystem {
          modules = [
            # Import the 'bjorn' host's configuration.nix file
            ./hosts/bjorn/configuration.nix
            ./modules/nixos
            # Enable Home Manager
            home-manager.nixosModules.home-manager
            {
              # Configure Home Manager
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                users.plarpoon.imports = [
                  ./modules/home-manager
                  ./users/plarpoon
                ];
              };
            }
          ];
          specialArgs = {
            inherit inputs;
          };
        };

        # Define a NixOS configuration for the 'daisy' host
        daisy = nixpkgs.lib.nixosSystem {
          modules = [
            # Import the 'daisy' host's configuration.nix file
            ./hosts/daisy/configuration.nix

            # Enable Home Manager
            home-manager.nixosModules.home-manager
            {
              # Configure Home Manager
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
