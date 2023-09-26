{ config, pkgs, ... }:

{
  users.users.plarpoon.isNormalUser = true;
  users.extraGroups = [ "wheel" "networkmanager" ];
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "it";
  services.rtkit.enable = true;
  services.polkit.enable = true;
  services.dconf.enable = true;
  services.pipewire.enable = true;
  services.printing.enable = true;
  nix.gc.automatic = true;
  nix.autoOptimiseStore = true;
}
