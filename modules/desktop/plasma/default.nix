{ lib, pkgs, ... }:

let
  # Plasma's optional bundled apps; each one is its own module in ./apps.
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
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages =
    lib.filter (p: p != null) (map (name: pkgs.kdePackages.${name} or null) bundledApps);
}
