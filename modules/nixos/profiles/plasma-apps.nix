{ config, lib, ... }:

# Everyday applications for a Plasma session.
let
  on = lib.mkDefault true;
in
{
  options.my.profiles.plasma-apps.enable = lib.mkEnableOption "everyday KDE applications and Firefox";

  config = lib.mkIf config.my.profiles.plasma-apps.enable {
    my.apps = {
      ark.enable = on;
      dolphin.enable = on;
      gwenview.enable = on;
      kate.enable = on;
      kcalc.enable = on;
      konsole.enable = on;
      okular.enable = on;
      spectacle.enable = on;
      firefox.enable = on;
    };
  };
}
