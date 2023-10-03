{ inputs, lib, pkgs, username, stateVersion, ... }:

{
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

  environment = {
    # Backup the currently active configuration in /etc/current-config
    etc."current-config".source = inputs.self.outPath;
    # Remove all default packages
    defaultPackages = lib.mkForce [];
    # Add packages system-wide
    systemPackages = with pkgs; [
      firefox
      neovim
      git
      zsh
      vscode
      partition-manager
      microsoft-edge
      direnv
    ];
    variables = {
      EDITOR = "neovim";
      VISUAL = "neovim";
    };
  };
}
