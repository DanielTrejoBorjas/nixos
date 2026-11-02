{ ... }:

# Everyday applications for a Plasma session.
{
  imports = [
    ../modules/desktop/plasma/apps/ark.nix
    ../modules/desktop/plasma/apps/dolphin.nix
    ../modules/desktop/plasma/apps/gwenview.nix
    ../modules/desktop/plasma/apps/kate.nix
    ../modules/desktop/plasma/apps/kcalc.nix
    ../modules/desktop/plasma/apps/konsole.nix
    ../modules/desktop/plasma/apps/okular.nix
    ../modules/desktop/plasma/apps/spectacle.nix

    ../modules/programs/firefox.nix
  ];
}
