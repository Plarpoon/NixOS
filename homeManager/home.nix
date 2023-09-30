{pkgs, ...}: {
  home = {
    username = "$USER";
    homeDirectory = "$HOME";
    stateVersion = "23.11";
    packages = [
      pkgs.vscode
      pkgs.steam
    ];
  };

  programs.home-manager.enable = true;
}