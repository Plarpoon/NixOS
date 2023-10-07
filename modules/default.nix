{ config, pkgs, lib, ... }:

{
  imports = 
    let
      plasmaModulePath = ./plasma.nix;
    in
      lib.optional config.plasmaEnable plasmaModulePath;
}
