{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # Generics
      steam         # Gaming platform
      firefox	      # Web browser

      # Comms
      discord       # Chat

      # Programming
      vscode        # IDE
    ];
  };
}
