{ config, pkgs, ... }:

{
  services.xserver.desktopManager.gnome3.enable = true;
  services.gnome3.gnome-software.enable = true;
}
