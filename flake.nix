/* 
.
├── flake.nix
├── hosts
│   ├── bjorn
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   ├── daisy
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   ├── default.nix
│   └── configuration.nix
└── modules
    ├── desktop
    │   ├── kde.nix
    │   ├── gnome.nix
    │   └── hyprland.nix
    └── options.nix
 */

{
  description = "A flake for my system configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixgl.url = "github:guibou/nixGL";
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nixgl, plasma-manager }: {
    nixosConfigurations = {
      plarpoon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.plarpoon = import ./hosts/configuration.nix;
            system.stateVersion = "23.11";  # Update this to the latest supported version
          }
        ];
      };
      bjorn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bjorn/default.nix
        ];
      };
      daisy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/daisy/default.nix
        ];
      };
    };
  };
}