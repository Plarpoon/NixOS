{ pkgs, ... }:

{
  home = {                                # Specific packages for desktop
    packages = with pkgs; [
      # Applications
      steam           # Gaming store
      vscode	      # IDE
      discord	      # Comm application
      firefox	      # Web browser
    ];
  };
}
