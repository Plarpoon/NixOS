#
#  Desktop Environments & Window Managers
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./desktops
#           ├─ default.nix *
#           └─ ...
#

{ config, pkgs, ... }:

{
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
  ];
}
