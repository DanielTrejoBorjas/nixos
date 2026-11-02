{ config, lib, ... }:

{
  options.my.services.flatpak.enable = lib.mkEnableOption "Flatpak";

  config = lib.mkIf config.my.services.flatpak.enable {
    services.flatpak.enable = true;
  };
}
