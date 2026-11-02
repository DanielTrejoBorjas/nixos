{ config, lib, ... }:

{
  options.my.apps.kdeconnect.enable = lib.mkEnableOption "KDE Connect";

  config = lib.mkIf config.my.apps.kdeconnect.enable {
    # Also opens the KDE Connect firewall ports.
    programs.kdeconnect.enable = true;
  };
}
