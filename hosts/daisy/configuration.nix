{
  networking.hostName = "daisy";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.11";

  ##remove these
  fileSystems."/".label = "x";
  boot.loader.grub.devices = [ "nodev" ];
}
