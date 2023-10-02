{
  inputs,
  lib,
  pkgs,
  username,
  stateVersion,
  ...
}: {
  imports = [
    # Import your hardware configuration
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## Misc
  time.timeZone = "Europe/Rome";

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
      # You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      #initialPassword = "nixos";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # Add your SSH public key(s) here, if you plan on using SSH to connect to this user
      ];
      # Be sure to add any other groups you need (such as audio, docker, etc)
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  networking.nameservers = [ 
    "45.90.28.0#bjorn-e38da2.dns.nextdns.io" 
    "2a07:a8c0::#bjorn-e38da2.dns.nextdns.io" 
    "45.90.30.0#bjorn-e38da2.dns.nextdns.io" 
    "2a07:a8c1::#bjorn-e38da2.dns.nextdns.io" 
  ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ 
      "45.90.28.0#bjorn-e38da2.dns.nextdns.io" 
      "2a07:a8c0::#bjorn-e38da2.dns.nextdns.io" 
      "45.90.30.0#bjorn-e38da2.dns.nextdns.io" 
      "2a07:a8c1::#bjorn-e38da2.dns.nextdns.io" 
    ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  ## SSH
  services.openssh = {
    enable = true;
    settings = {
      # Allow only key based ssh access
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  ## nixpkgs
  nixpkgs = {
    #The system to build this configuration for
    hostPlatform = "x86_64-linux";
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        # Add unfree packages you would like to allow here.
        # for example:
        "vscode"
        "microsoft-edge-stable"
      ];
  };

  ## Networking
  networking = {
    # Set this systems hostname
    hostName = "bjorn";
    # NetworkManager is the easiest there is multiple other options
    networkmanager.enable = true;
    useDHCP = false;
  };

  ## Sound
  # This is badly named and is only for ALSA
  sound.enable = lib.mkForce false;
  # We don't need pulseaudio because pipewire has a emulated version
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  # Enable and configure pipewire
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # Optional jack support
    #jack.enable = true;
  };

  hardware = {
    # Your system will likely be un-bootable without this
    enableRedistributableFirmware = true;
    # Uncomment one of these depending on your CPU
    cpu.intel.updateMicrocode = true;
    #cpu.amd.updateMicrocode = true;
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

  ## Nix settings
  nix = {
    # Pin nixpkgs in the flake registry and $NIX_PATH to your system flakes nixpkgs
    nixPath = ["nixpkgs=flake:nixpkgs"];
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      # Ignore global registry
      flake-registry = "";

      # Enable flakes and the "nix" command
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      # Reduce disk usage
      auto-optimise-store = true;
    };
  };

  ## Environment
  environment = {
    # Backup the currently active configuration in /etc/current-config
    etc."current-config".source = inputs.self.outPath;
    # Remove all default packges
    defaultPackages = lib.mkForce [];
    # Add packages system-wide
    systemPackages = [
      pkgs.firefox
      pkgs.neovim
      pkgs.git
      pkgs.zsh
      pkgs.vscode
      pkgs.partition-manager
      pkgs.microsoft-edge
      pkgs.direnv
    ];
    variables = {
      EDITOR = "neovim";
      VISUAL = "neovim";
    };
  };

  # KDE
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  system.stateVersion = stateVersion;
}
