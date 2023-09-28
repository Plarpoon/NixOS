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

{
  gnome = import ./gnome.nix;
  hyprland = import ./hyprland.nix;
  kde = import ./kde.nix;
}
