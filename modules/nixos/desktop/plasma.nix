{ config, lib, pkgs, ... }:

let
  cfg = config.my.desktop.plasma;

  # Plasma's optional bundled apps; each one is its own module in ../apps/kde.
  # `or null` tolerates names that nixpkgs renamed or dropped.
  bundledApps = [
    "ark"
    "baloo-widgets"
    "dolphin"
    "dolphin-plugins"
    "elisa"
    "ffmpegthumbs"
    "gwenview"
    "kate"
    "khelpcenter"
    "konsole"
    "krdp"
    "ktexteditor"
    "okular"
    "plasma-browser-integration"
    "spectacle"
  ];
in
{
  options.my.desktop.plasma.enable = lib.mkEnableOption "a minimal Plasma 6 desktop without bundled apps";

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages =
      lib.filter (p: p != null) (map (name: pkgs.kdePackages.${name} or null) bundledApps);
  };
}
