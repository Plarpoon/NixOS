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
      ## AppImages
      appimage-run # Run appimages on NixOS

      ## Portals
      xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
      xwaylandvideobridge # Utility to allow streaming Wayland windows to X applications

      ## SDK
      android-tools # Android SDK platform tools

      ## Torrent client
      qbittorrent # Featureful free software BitTorrent client

      ## Dictionary
      nuspell # Free and open source C++ spell checking library

      ## Fonts
      nerdfonts # Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts

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
      gparted # Graphical disk partitioning tool
      #etcher # Flash OS images to SD cards and USB drives, safely and easily

      # Environment Management
      direnv # A shell extension that manages your environment

      # Nix Formatter
      nixpkgs-fmt # Nix code formatter for nixpkgs

      # Communication
      whatsapp-for-linux # Whatsapp desktop messaging app

      # Encryption
      gnupg # OpenPGP implementation

      # Image Editing
      gimp-with-plugins # GNU Image Manipulation Program
      krita # Digital painting program

      # Rust Linux core utilities
      ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep

      # Video player
      vlc # Cross-platform media player and streaming server

      # Video ripper
      makemkv # Convert blu-ray and dvd to mkv

      # Windows translation layers
      wine-staging # Windows translation layer
      winetricks # A script to install DLLs needed to work around problems in Wine
      protontricks # A simple wrapper for running Winetricks commands for Proton-enabled games

      # OBS
      obs-studio # Streaming and recording software
      obs-studio-plugins.obs-vaapi # VAAPI-plugin for OBS

      # Econders/Decoders
      svt-av1 # AV1-compliant encoder/decoder library core
      dav1d # A cross-platform AV1 decoder focused on speed and correctness
      rav1e # The fastest and safest AV1 encoder
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
    };
  };
}
