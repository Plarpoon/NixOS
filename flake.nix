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
          { pkgs, ... }: { imports = [ ./hosts/bjorn/configuration.nix ]; }
          self.inputs.home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.users.${self.username} = self.homeConfigurations.${self.username}; 
            system.stateVersion = self.stateVersion;
          })
        ];
        specialArgs = { inherit inputs username stateVersion; };
      };

      daisy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { pkgs, ... }: { imports = [ ./hosts/daisy/configuration.nix ]; }
          self.inputs.home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.users.${self.username} = self.homeConfigurations.${self.username}; 
            system.stateVersion = self.stateVersion;
          })
        ];
        specialArgs = { inherit inputs username stateVersion; };
      };
    };
  };
}
