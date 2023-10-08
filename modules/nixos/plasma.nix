{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    kde = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf config.kde.enable {
    programs = {
      zsh.enable = true;
    };

    services = {
      xserver = {
        enable = true;

        libinput.enable = true;
        modules = [ pkgs.xf86_input_wacom ];
        wacom.enable = true;

        displayManager = {
          sddm.enable = true; # Display Manager
          defaultSession = "plasmawayland";
        };
        desktopManager.plasma5 = {
          enable = true; # Desktop Environment
        };
      };
    };

    environment = {
      systemPackages = with pkgs.libsForQt5; [
        # System-Wide Packages
        bismuth # Dynamic Tiling
        packagekit-qt # Package Updater
      ];
    };
  };
}
