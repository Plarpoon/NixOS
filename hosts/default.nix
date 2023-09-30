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

{ lib, inputs, nixpkgs, home-manager, nur, plasma-manager, vars, modules, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  bjorn = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs pkgs vars;
    };
    modules = [
      { config, ... }: { imports = [ ./bjorn ]; }
      ./configuration.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  daisy = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs pkgs vars;
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
