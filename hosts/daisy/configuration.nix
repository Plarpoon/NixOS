{ pkgs
, ...
}:

{
  ##FIX ME
  boot.loader.grub.devices = [ "nodev" ];

  imports = [
    # Import your hardware configuration
    ./hardware-configuration.nix
  ];
  ## My modules
  kde = {
    enable = true;
  };

  ## Kernel parameters
  boot.kernelParams = [ "pcie_port_pm=off" "pcie_aspm.policy=performance" ];

  ## OpenCL
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    rocmPackages.clr
    amdvlk
  ];

  ## Vulkan
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;

  # For 32 bit applications 
  # Only available on unstable
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  ## Users
  users.users = {
    plarpoon = {
      isNormalUser = true; # The user is a normal user (not a system user)
      openssh.authorizedKeys.keys =
        [
          # Add your SSH public key(s) here, if you plan on using SSH to connect to this user
        ];
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  networking.nameservers = [
    "45.90.28.0#daisy-e38da2.dns.nextdns.io"
    "2a07:a8c0::#daisy-e38da2.dns.nextdns.io"
  ];

  services.resolved = {
    enable = true; # Enable systemd-resolved for DNS resolution
    dnssec = "true"; # Enable DNSSEC for DNS resolution
    domains = [ "~." ]; # Use these DNS servers for all domains
    fallbackDns = [
      "45.90.30.0#daisy-e38da2.dns.nextdns.io"
      "2a07:a8c1::#daisy-e38da2.dns.nextdns.io"
    ];
    extraConfig = ''
      DNSOverTLS=yes   # Use DNS over TLS for DNS resolution
    '';
  };

  ## Networking
  networking = {
    hostName = "daisy"; # Set this system's hostname

    networkmanager.enable = true; # Enable NetworkManager for network configuration

    useDHCP = false; # Do not use DHCP for network configuration (use static IP addresses)
  };

  hardware.enableRedistributableFirmware = true; # Enable redistributable firmware (may be required for some hardware)

  hardware.cpu.amd.updateMicrocode = true; # Update CPU microcode (for Intel CPUs)

  system.stateVersion = "23.11";
}
