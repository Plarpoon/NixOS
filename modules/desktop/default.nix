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

[
  ./gnome.nix
  ./hyprland.nix
  ./kde.nix
]