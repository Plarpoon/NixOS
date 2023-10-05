{ config, lib, ... }:

let
  plasmaModule = import ./plasma.nix;
in
{
  options = {
    programs.plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable the Plasma module.";
    };
  };

  config = lib.mkIf config.programs.plasma.enable {
    programs.plasma = plasmaModule;
  };
}
