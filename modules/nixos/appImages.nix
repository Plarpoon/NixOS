{ pkgs
, ...
}:

let
  appimageTools = pkgs.appimageTools;
in
appimageTools.wrapType2 {
  # or wrapType1
  name = "wowup-cf";
  src = fetchurl {
    url = "https://github.com/WowUp/WowUp.CF/releases/download/v2.10.0/WowUp-CF-2.10.0.AppImage";
    hash = "sha256-bbcaf38a87764554826aa48181286a15e56b468f4cbc7afb702ba348062950b3";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}
