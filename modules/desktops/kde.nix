#
#  KDE Plasma 5 Configuration
#  Enable with "kde.enable = true;"
#  Get the plasma configs in a file with $ nix run github:pjones/plasma-manager > <file>
#

{ config, lib, pkgs, vars, inputs, ... }:

with lib;
{
  options = {
    kde = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.kde.enable) {
    programs = {
      zsh.enable = true;
      kdeconnect = {                                # For GSConnect
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
    };

    services = {
      xserver = {
        enable = true;

        layout = "it";
        libinput.enable = true;

        displayManager = {
          sddm.enable = true;                       # Display Manager
          defaultSession = "plasmawayland";
        };
        desktopManager.plasma5 = {
          enable = true;                            # Desktop Environment
        };
      };
    };

    environment = {
      systemPackages = with pkgs.libsForQt5; [      # System-Wide Packages
        packagekit-qt   # Package Updater
      ];
    };

    home-manager.users.${vars.user} = {
      imports = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
      ];
      programs.plasma = {
        enable = true;
      };
    };
  };
}
