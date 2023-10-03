{ inputs, lib, pkgs, username, stateVersion, ... }:

{
  ## Nix configuration
  nix = {
    nixPath = [ "nixpkgs=flake:nixpkgs" ]; # Pin nixpkgs in the flake registry and $NIX_PATH to your system flakes nixpkgs

    registry.nixpkgs.flake = inputs.nixpkgs; # Set the nixpkgs flake in the Nix registry to the nixpkgs input of this flake

    settings = {
      flake-registry = ""; # Ignore global registry

      experimental-features = [
        # Enable experimental features
        "flakes"
        "nix-command"
      ];

      auto-optimise-store = true; # Reduce disk usage by deduplicating identical files in the Nix store
    };
  };

  ## Boot
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  ## nixpkgs
  nixpkgs = {
    hostPlatform = "x86_64-linux"; # The system to build this configuration for

    config.allowUnfree = true;
  };

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

      # Shell
      zsh # Interactive shell

      # Disk Management
      partition-manager # Disk utility

      # Environment Management
      direnv # Env switcher

      # Nix Formatter
      nixpkgs-fmt # Nix code formatter

      # Communication
      discord # Communication platform

      # Encryption
      gnupg # OpenPGP implementation 

      # Image Editing
      gimp-with-plugins # GNU Image Manipulation Program
      krita # Digital painting program
    ];
    variables = {
      EDITOR = "neovim";
      VISUAL = "neovim";
    };
  };

  ## Sound
  sound = {
    enable = lib.mkForce false; # Disable sound (ALSA)
  };

  hardware.pulseaudio = {
    enable = lib.mkForce false; # Disable PulseAudio (use PipeWire instead)
  };

  security.rtkit = {
    enable = true; # Enable RealtimeKit for real-time scheduling in PulseAudio
  };

  services.pipewire = {
    enable = true; # Enable PipeWire for audio and video handling

    alsa = {
      enable = true; # Enable ALSA support in PipeWire
      support32Bit = true; # Enable support for ALSA's i386 ABI in PipeWire
    };

    pulse = {
      enable = true; # Enable PulseAudio support in PipeWire
    };
  };

  ## Desktop
  services = {
    xserver = {
      enable = true; # Enable the X server

      displayManager.sddm = {
        enable = true; # Enable the SDDM display manager
      };

      desktopManager.plasma5 = {
        enable = true; # Enable the Plasma 5 desktop environment
      };
    };
  };

  ## Pinentry
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
}
