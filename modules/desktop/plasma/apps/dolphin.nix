{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.kdePackages; [
    dolphin
    dolphin-plugins
    baloo-widgets
    ffmpegthumbs
  ];
}
