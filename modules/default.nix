{ config, inputs, lib, pkgs, username, stateVersion, vars, ... }:

let
  plasmaConfig = import ./plasma.nix { inherit config inputs lib pkgs username stateVersion vars; };
in
{
  imports = [
    # Import the plasma configuration if plasma is enabled
    (lib.mkIf config.plasma.enable plasmaConfig)
  ];
}
