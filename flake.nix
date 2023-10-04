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

    # Add pjones's plasma-manager
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Define the outputs for the flake
  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs:
    let
      # Define some variables
      username = "plarpoon";
      stateVersion = "23.11";
    in
    {
      nixosConfigurations = {
        # Define a NixOS configuration for the 'bjorn' host
        bjorn = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Import the 'bjorn' host's configuration.nix file
            ./hosts/bjorn/configuration.nix

            # Enable Home Manager
            home-manager.nixosModules.home-manager

            ({ config, pkgs, ... }: {
              # Configure Home Manager
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Import the 'bjorn' host's home.nix file into Home Manager
              home-manager.users.${username} = import ./hosts/bjorn/home.nix {
                inherit inputs username stateVersion pkgs;
                config = config.home-manager.users.${username};
              };

              system.stateVersion = stateVersion;
            })
          ];
          specialArgs = { inherit inputs username stateVersion; };
        };

        # Define a NixOS configuration for the 'daisy' host
        daisy = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Import the 'daisy' host's configuration.nix file
            ./hosts/daisy/configuration.nix

            # Enable Home Manager
            home-manager.nixosModules.home-manager

            ({ config, pkgs, ... }: {
              # Configure Home Manager
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Import the 'daisy' host's home.nix file into Home Manager
              home-manager.users.${username} = import ./hosts/daisy/home.nix {
                inherit inputs username stateVersion pkgs;
                config = config.home-manager.users.${username};
              };

              system.stateVersion = stateVersion;
            })
          ];
          specialArgs = { inherit inputs username stateVersion; };
        };
      };
    };
}
