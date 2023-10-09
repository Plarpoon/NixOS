{
  config,
  inputs,
  lib,
  pkgs,
  username,
  stateVersion,
  vars,
  ...
}:

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

  boot.kernelPackages = pkgs.linuxPackages_latest; # Use the latest Linux kernel packages

  ## Misc
  time.timeZone = "Europe/Rome"; # Set the system time zone

  ## Set the system locale
  i18n = {
    defaultLocale = "it_IT.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "it_IT.UTF-8/UTF-8"
    ];
  };

  # Set the console keymap
  console.keyMap = "it";

  ## Printer and Scanner
  services.printing.enable = true; # Enable the CUPS printing system
  hardware.sane.enable = true; # Enable the SANE scanner system

  ## Sound
  sound.enable = lib.mkForce false; # Disable sound (ALSA)

  hardware.pulseaudio.enable = lib.mkForce false; # Disable PulseAudio (use PipeWire instead)

  security.rtkit.enable = true; # Enable RealtimeKit for real-time scheduling in PulseAudio

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
  services.xserver.enable = true; # Enable the X server

  displayManager.sddm.enable = true; # Enable the SDDM display manager

  layout.xserver.layout = "it"; # Set the keyboard layout

  ## Pinentry
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor = "qt";
}