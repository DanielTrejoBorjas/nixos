{ config, lib, pkgs, ... }:

{
  options.my.apps.kcalc.enable = lib.mkEnableOption "KCalc calculator";

  config = lib.mkIf config.my.apps.kcalc.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      kcalc
    ];
  };
}
