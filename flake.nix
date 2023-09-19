{
  description = "A flake containing all of my NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        bjorn = lib.nixosSystem {
          inherit system;
          modules = [
            ./bjorn/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.plarpoon = {
                imports = [ ./bjorn/home.nix ];
		home.stateVersion = "23.05";
              };
            }
          ];
        };
        daisy = lib.nixosSystem {
          inherit system;
	  modules = [
            ./daisy/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.plarpoon = {
                imports = [ ./daisy/home.nix ];
		home.stateVersion = "23.05";
              };
            }
          ];
        };
      };
    };
}
