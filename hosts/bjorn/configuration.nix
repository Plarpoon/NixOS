{ config, inputs, lib, pkgs, username, stateVersion, vars, ... }:

let
  sharedConfig = import ../default.nix { inherit config inputs lib pkgs username stateVersion vars; };
in
{
  imports = [
    # Import your hardware configuration
    ./hardware-configuration.nix

    # Import the shared configuration
    sharedConfig
  ];

  config = {
    ## Users
    users.users = {
      "${username}" = {
        isNormalUser = true; # The user is a normal user (not a system user)
        openssh.authorizedKeys.keys = [
          # Add your SSH public key(s) here, if you plan on using SSH to connect to this user
        ];
        extraGroups = [ "wheel" "networkmanager" ]; # The user is part of the 'wheel' and 'networkmanager' groups
      };
    };

    networking.nameservers = [
      "45.90.28.0#bjorn-e38da2.dns.nextdns.io"
      "2a07:a8c0::#bjorn-e38da2.dns.nextdns.io"
    ];

    services.resolved = {
      enable = true; # Enable systemd-resolved for DNS resolution
      dnssec = "true"; # Enable DNSSEC for DNS resolution
      domains = [ "~." ]; # Use these DNS servers for all domains
      fallbackDns = [
        "45.90.30.0#bjorn-e38da2.dns.nextdns.io"
        "2a07:a8c1::#bjorn-e38da2.dns.nextdns.io"
      ];
      extraConfig = ''
        DNSOverTLS=yes   # Use DNS over TLS for DNS resolution
      '';
    };

    ## Networking
    networking = {
      hostName = "bjorn"; # Set this system's hostname

      networkmanager.enable = true; # Enable NetworkManager for network configuration

      useDHCP = false; # Do not use DHCP for network configuration (use static IP addresses)
    };

    hardware.enableRedistributableFirmware = true; # Enable redistributable firmware (may be required for some hardware)

    hardware.cpu.intel.updateMicrocode = true; # Update CPU microcode (for Intel CPUs)

    system.stateVersion = stateVersion; # Set the system state version

    plasma.enable = true; # Enable KDE Plasma
  };
}
