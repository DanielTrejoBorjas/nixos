{ config, lib, ... }:

let
  cfg = config.my.hardware.laptop;
in
{
  options.my.hardware.laptop.enable = lib.mkEnableOption "laptop support (power profiles, battery, sensors, touchpad)";

  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    hardware.sensor.iio.enable = true; # auto-rotate, ambient light

    services.libinput.touchpad = {
      tapping = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
    };
  };
}
