{ config, lib, pkgs, ... }:

{
  options.my.apps.dolphin.enable = lib.mkEnableOption "Dolphin file manager with plugins and thumbnails";

  config = lib.mkIf config.my.apps.dolphin.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      dolphin
      dolphin-plugins
      baloo-widgets
      ffmpegthumbs
    ];
  };
}
