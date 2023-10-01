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

  outputs = { self, nixpkgs, home-manager, ... }: let  # Add this line
    username = self.username;  # Add this line
    stateVersion = self.stateVersion;  # Add this line
  in {  # Add this line
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
      ];
      extraSpecialArgs = { inherit inputs username stateVersion; }; 
    };

    nixosConfigurations = {
      bjorn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bjorn/configuration.nix  
          self.inputs.home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.users.${username} = self.homeConfigurations.${username}; 
            system.stateVersion = stateVersion;
          })
        ];
        specialArgs = { inherit inputs username stateVersion; };
      };

      daisy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/daisy/configuration.nix  
          self.inputs.home-manager.nixosModules.home-manager
          ({ config, pkgs, ... }: {
            home-manager.users.${username} = self.homeConfigurations.${username}; 
            system.stateVersion = stateVersion;
          })
        ];
        specialArgs = { inherit inputs username stateVersion; };
      };
    };
  };
}
