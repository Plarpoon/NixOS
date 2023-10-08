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

      # Shell
      zsh # Interactive shell

      # Disk Management
      gparted # Disk utility

      # Environment Management
      direnv # Env switcher

      # Nix Formatter
      nixpkgs-fmt # Nix code formatter

      # Communication
      discord # Discord client
      whatsapp-for-linux # WhatsApp client

      # Encryption
      gnupg # OpenPGP implementation

      # Image Editing
      gimp-with-plugins # GNU Image Manipulation Program
      krita # Digital painting program

      # Misc Programs
      latte-dock # KDE's dock replacement
    ];
    variables = {
      EDITOR = "neovim";
      VISUAL = "neovim";
    };
  };

  ## Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}