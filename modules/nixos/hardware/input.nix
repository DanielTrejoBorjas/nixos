{ config, lib, ... }:

let
  cfg = config.my.hardware.input;
in
{
  options.my.hardware.input.enable = lib.mkEnableOption "libinput and USB mode switching";

  config = lib.mkIf cfg.enable {
    services.libinput.enable = true;
    hardware.usb-modeswitch.enable = true;
  };
}
