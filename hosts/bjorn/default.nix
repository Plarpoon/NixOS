{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix  
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [
    vaapiIntel
    libvdpau-va-gl
  ];

  hardware.opengl.extraPackages64 = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
  ];

  networking.hostName = "bjorn";  # Set the hostname to "bjorn"
  networking.networkmanager.enable = true;  # Enable NetworkManager

  services.kresd.config = ''
    policy.add(policy.all(policy.TLS_FORWARD({
      {'45.90.28.0', hostname='bjorn-e38da2.dns.nextdns.io'},
      {'2a07:a8c0::', hostname='bjorn-e38da2.dns.nextdns.io'},
      {'45.90.30.0', hostname='bjorn-e38da2.dns.nextdns.io'},
      {'2a07:a8c1::', hostname='bjorn-e38da2.dns.nextdns.io'}
    })))
  '';

  desktop.kde.enable = true;

  system.stateVersion = "23.11"; # Update this to the latest supported version.
}