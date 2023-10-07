{ config, lib, pkgs, ... }:

{
  options = {
    kde.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE Plasma";
    };
  };

  imports = [
    # Import your Plasma configuration
    ./plasma.nix
  ];
}
