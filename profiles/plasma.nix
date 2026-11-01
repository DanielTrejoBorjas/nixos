{ ... }:

# Graphical session: SDDM + Plasma 6 + audio + browser.
{
  imports = [
    ../modules/desktop/sddm.nix
    ../modules/desktop/plasma.nix
    ../modules/desktop/audio.nix
    ../modules/programs/browser.nix
  ];
}
