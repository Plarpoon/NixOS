{
  username = "plarpoon";
  stateVersion = "23.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    homeConfigurations.${self.username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
      ];
      extraSpecialArgs = {inherit inputs;};
    };

    nixosConfigurations = {
      bjorn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bjorn/configuration.nix
          self.inputs.home-manager.nixosModules.home-manager
          { 
            home-manager.users.${self.username} = self.homeConfigurations.${self.username}; 
            system.stateVersion = self.stateVersion;
          }
        ];
      };

      daisy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/daisy/configuration.nix
          self.inputs.home-manager.nixosModules.home-manager
          { 
            home-manager.users.${self.username} = self.homeConfigurations.${self.username}; 
            system.stateVersion = self.stateVersion;
          }
        ];
      };
    };
  };
}
