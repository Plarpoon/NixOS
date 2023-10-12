{ config
, lib
, pkgs
, ...
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

      ## Pinentry
      gnupg.agent.enable = true;
      gnupg.agent.pinentryFlavor = "qt";
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

        layout = "it"; # Set the keyboard layout
      };
    };

    environment = {
      systemPackages = with pkgs; [
        # System-Wide Packages
        # Icon themes
        tela-icon-theme

        # Theme
        catppuccin-kde

        # Cursor
        catppuccin-cursors

        # SDDM theme
        catppuccin-sddm-corners

        (pkgs.libsForQt5.packagekit-qt) # Package Updater
      ];
    };

    ## Enable KDEConnect
    programs.kdeconnect = {
      enable = true;
    };
  };
}
