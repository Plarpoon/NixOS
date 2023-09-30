#
#  These are the different profiles that can be used when building NixOS.
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       └─ ./<host>.nix
#           └─ default.nix 
#

{ inputs, nixpkgs, home-manager, nur, plasma-manager, vars, modules, ... }:

let
  lib = nixpkgs.lib;
in
{
  bjorn = lib.nixosSystem {
    specialArgs = {
      inherit inputs vars;
    };
    modules = [
      ./bjorn
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  daisy = lib.nixosSystem {
    specialArgs = {
      inherit inputs vars;
      host = {
        hostName = "daisy";
      };
    };
    modules = [
      nur.nixosModules.nur
      ./daisy
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
