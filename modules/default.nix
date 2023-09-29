{ config, pkgs, ... }:

{
  imports = [
    ./desktop/default.nix
    ./theming/default.nix
  ];
}
