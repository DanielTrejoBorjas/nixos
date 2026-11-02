{ config, lib, ... }:

let
  cfg = config.my.hardware.logitech;
in
{
  options.my.hardware.logitech.enable = lib.mkEnableOption "Logitech wireless devices (Unifying/Bolt) with Solaar";

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;
  };
}
