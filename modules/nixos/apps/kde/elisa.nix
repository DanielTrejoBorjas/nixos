{ config, lib, pkgs, ... }:

{
  options.my.apps.elisa.enable = lib.mkEnableOption "Elisa music player";

  config = lib.mkIf config.my.apps.elisa.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      elisa
    ];
  };
}
