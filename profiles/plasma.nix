{ ... }:

# Minimal graphical session: SDDM + Plasma 6 without bundled apps or audio.
# Pair with profiles/plasma-apps.nix and an audio module (pipewire or pulseaudio).
{
  imports = [
    ../modules/desktop/sddm.nix
    ../modules/desktop/plasma
  ];
}
