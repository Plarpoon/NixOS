{ config, pkgs, ... }:

{
  # User configuration
  users.users.plarpoon.isNormalUser = true;
  users.extraGroups = [ "wheel" "networkmanager" ];

  # Locale and keyboard layout configuration
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "it";

  # Services configuration
  services.rtkit.enable = true;  # Enable RealtimeKit, a D-Bus system service that allows real-time scheduling for user processes
  services.polkit.enable = true;  # Enable PolicyKit, an application-level toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
  services.dconf.enable = true;  # Enable DConf, a low-level configuration system
  services.pipewire.enable = true;  # Enable PipeWire, a server for handling audio and video streams

  # Hardware configuration
  hardware.sane = {
    enable = true;  # Enable Scanner Access Now Easy (SANE), an API that provides access to scanners
    extraBackends = [ pkgs.sane-airscan ];  # Add 'sane-airscan' as an extra backend for SANE
  };

  # Printing configuration
  services.printing.enable = true;  # Enable printing services
  services.printing.drivers = [ pkgs.hplip ];  # Use 'hplip' as the driver for printing services

  # Nix configuration
  nix.gc.automatic = true;  # Enable automatic garbage collection for Nix
  nix.autoOptimiseStore = true;  # Enable automatic optimization of the Nix store
}
