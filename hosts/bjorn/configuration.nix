{
  inputs,  # Inputs from the flake
  lib,     # Nixpkgs library functions
  pkgs,    # Nix packages
  username,  # Username for the system
  stateVersion,  # NixOS state version
  ...
}:

let
  # Import the shared configuration from default.nix
  sharedConfig = import ../default.nix { inherit inputs lib pkgs username stateVersion; };
in
{
  imports = [
    # Import your hardware configuration
    ./hardware-configuration.nix

    # Import the shared configuration
    sharedConfig
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;  # Use the latest Linux kernel packages

  ## Misc
  time.timeZone = "Europe/Rome";  # Set the system time zone

  # Set the system locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # Set the X11 keymap
  services.xserver = {
    layout = "it";
  };

  # Set the console keymap
  console.keyMap = "it";
  
  ## Users
  users.users = {
    "${username}" = {
      isNormalUser = true;   # The user is a normal user (not a system user)
      openssh.authorizedKeys.keys = [
        # Add your SSH public key(s) here, if you plan on using SSH to connect to this user
      ];
      extraGroups = ["wheel" "networkmanager"];   # The user is part of the 'wheel' and 'networkmanager' groups
    };
  };

  networking.nameservers = [ 
    "45.90.28.0#bjorn-e38da2.dns.nextdns.io" 
    "2a07:a8c0::#bjorn-e38da2.dns.nextdns.io" 
  ];

  services.resolved = {
    enable = true;   # Enable systemd-resolved for DNS resolution
    dnssec = "true";   # Enable DNSSEC for DNS resolution
    domains = [ "~." ];   # Use these DNS servers for all domains
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
    hostName = "bjorn";   # Set this system's hostname

    networkmanager.enable = true;   # Enable NetworkManager for network configuration

    useDHCP = false;   # Do not use DHCP for network configuration (use static IP addresses)
  };

hardware.enableRedistributableFirmware = true;   # Enable redistributable firmware (may be required for some hardware)

hardware.cpu.intel.updateMicrocode = true;   # Update CPU microcode (for Intel CPUs)

system.stateVersion = stateVersion;   # Set the system state version
}
