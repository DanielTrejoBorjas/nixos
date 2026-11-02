{ config, lib, ... }:

let
  cfg = config.my.system.security;
in
{
  options.my.system.security.enable = lib.mkEnableOption "polkit and wheel-only sudo";

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
    security.sudo.execWheelOnly = true;
  };
}
