{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    desktop.kde.enable = mkEnableOption "KDE desktop environment";
    desktop.gnome.enable = mkEnableOption "GNOME desktop environment";
    desktop.hyprland.enable = mkEnableOption "Hyprland desktop environment";
  };

  config = mkIf config.desktop.kde.enable {
    imports = [ ./desktop/kde.nix ];
  } // mkIf config.desktop.gnome.enable {
    imports = [ ./desktop/gnome.nix ];
  } // mkIf config.desktop.hyprland.enable {
    imports = [ ./desktop/hyprland.nix ];
  };
}
