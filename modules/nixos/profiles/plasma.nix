{ config, lib, ... }:

# Minimal graphical session: SDDM + Plasma 6 without bundled apps.
# Audio is chosen separately with my.audio.backend.
{
  options.my.profiles.plasma.enable = lib.mkEnableOption "SDDM and a minimal Plasma 6 session";

  config = lib.mkIf config.my.profiles.plasma.enable {
    my.desktop = {
      sddm.enable = lib.mkDefault true;
      plasma.enable = lib.mkDefault true;
    };
  };
}
