#
#  Specific system configuration settings for laptop
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./laptop
#           └─ default.nix
#

{ pkgs, vars, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {                                      # Boot Options
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware = {
    opengl = {                                  # Hardware Accelerated Video
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs; [
        pkgsi686Linux.vaapiIntel
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
    sane = {                                    # Scanning
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };

  laptop.enable = true;                       # Laptop modules
  kde.enable = true;                          # KDE DE

  environment = {
    systemPackages = with pkgs; [               # System-Wide Packages
      hugo              # Static Website Builder
      simple-scan       # Scanning
    ];
  };
}