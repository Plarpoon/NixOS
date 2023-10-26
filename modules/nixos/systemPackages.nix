{ pkgs
, inputs
, lib
, config
, ...
}:

{
  environment = {
    # Backup the currently active configuration in /etc/current-config
    etc."current-config".source = inputs.self.outPath;
    # Remove all default packages
    defaultPackages = lib.mkForce [ ];
    # Add packages system-wide
    systemPackages = with pkgs; [
      ## Portals
      xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
      xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications

      ## SDK
      android-tools

      ## Torrent client
      qbittorrent

      ## Dictionary
      nuspell

      ## Fonts
      nerdfonts

      # Browsers
      firefox # Open-source browser
      microsoft-edge # Microsoft's browser

      # Editors
      vscode # Microsoft's editor
      kate # KDE's editor
      libreoffice-fresh # LibreOffice but more frequently updated

      # Version Control
      git # Distributed VCS

      # Programming
      dotnet-sdk_7 # set of SDK tools and language compilers
      dotnet-runtime_7 # .NET runtime
      dotnet-aspnetcore_7 # ASP.NET Core

      # Disk Management
      gparted # Disk utility

      # Environment Management
      direnv # Env switcher

      # Nix Formatter
      nixpkgs-fmt # Nix code formatter

      # Communication
      whatsapp-for-linux # WhatsApp client

      # Encryption
      gnupg # OpenPGP implementation

      # Image Editing
      gimp-with-plugins # GNU Image Manipulation Program
      krita # Digital painting program

      # Video player
      vlc # video player

      # Video ripper
      makemkv # creates MKV out of DVD/BluRays

      # Windows translation layers
      wine-staging # Windows translation layer
      winetricks # A script to install DLLs needed to work around problems in Wine
      protontricks # A simple wrapper for running Winetricks commands for Proton-enabled games

      # OBS
      obs-studio # Streaming and recording software
      obs-studio-plugins.obs-vaapi # VAAPI-plugin for OBS

      # Econders/Decoders
      svt-av1
      dav1d
      rav1e
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  ## Enable flatpak (only because of Bottles official support unfortunately)
  services = {
    flatpak.enable = true;

    cron = {
      enable = true;

      ## update flatpaks every 3 hours
      systemCronJobs = [
        "0 */3 * * * plarpoon flatpak update --noninteractive --assumeyes"
      ];
    };
  };

  ## Programs
  programs = {
    gamemode.enable = true;

    ## Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    ## Nix-index
    nix-index = {
      enableZshIntegration = true;
    };

    ## ZSH
    zsh = {
      enable = true;

      ## Define aliases
      shellAliases = {
        ## ll = "ls -l";
        ## update = "sudo nixos-rebuild switch";
      };

      ## Colored ls output
      enableLsColors = true;

      ## Configure Zsh history
      histSize = 10000;
      histFile = "$HOME/.zsh_history";

      ## Enable autosuggestions
      autosuggestions = {
        enable = true;
        async = true;
      };

      ## Enable completion
      enableCompletion = true;

      ## Enable syntax highlighting
      syntaxHighlighting = {
        enable = true;
      };
    };

    ## Starship
    starship = {
      enable = true;
    };

    ## NeoVIM
    neovim = {
      enable = true;
      configure = {
        customRC = ''
          " here your custom configuration goes!
        '';
        packages.myVimPackage = with pkgs.vimPlugins; {
          # loaded on launch
          start = [ nvchad ];
          # manually loadable by calling `:packadd $plugin-name`
          opt = [ ];
        };
      };
    };
  };
}
