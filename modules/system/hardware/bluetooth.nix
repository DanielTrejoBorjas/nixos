{ config, lib, ... }:

let
  cfg = config.my.hardware.bluetooth;
in
{
  options.my.hardware.bluetooth.enable = lib.mkEnableOption "Bluetooth, powered on at boot";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true; # battery level reporting
    };
  };
}
