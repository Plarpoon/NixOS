#
#  flake.nix *             
#   └─  ./hosts
#       └─ default.nix
#

{
  description = "NixOS Flake Configuration";

  inputs =                                                                  # References Used by Flake
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                     # Stable Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {                                                               # NUR Community Packages
        url = "github:nix-community/NUR";                                   # Requires "nur.nixosModules.nur" to be added to the host modules
      };

      nixgl = {                                                             # Fixes OpenGL With Other Distros.
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      plasma-manager = {                                                    # KDE Plasma User Settings Generator
        url = "github:pjones/plasma-manager";                               # Requires "inputs.plasma-manager.homeManagerModules.plasma-manager" to be added to the home-manager.users.${user}.imports
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nur, nixgl, home-manager, plasma-manager, ... }:   # Function telling flake which inputs to use
    let
      vars = {                                                              # Variables Used In Flake
        user = "plarpoon";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = (                                               # NixOS Configurations
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nur plasma-manager vars;   # Inherit inputs
        }
      );
      homeConfigurations = (                                                # Nix Configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nixgl vars;
        }
      );
    };
}