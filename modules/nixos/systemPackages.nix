{ config
, inputs
, lib
, pkgs
, username
, stateVersion
, vars
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
      # Browsers
      firefox # Open-source browser
      microsoft-edge # Microsoft's browser

      # Editors
      neovim # Vim-based editor
      vscode # Microsoft's editor
      kate # KDE's editor

      # Version Control
      git # Distributed VCS

      # Programming
      dotnet-sdk_7 # set of SDK tools and language compilers
      dotnet-runtime_7 # .NET runtime
      dotnet-aspnetcore_7 # ASP.NET Core

      # Shell
      zsh # Interactive shell

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
    ];
    variables = {
      EDITOR = "neovim";
      VISUAL = "neovim";
    };
  };

  ## Enable flatpak (only because of Bottles official support unfortunately)
  services.flatpak.enable = true;

  ## Programs
  programs = {
    gamemode.enable = true;

    ## Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
  };
}
