{ config, lib, pkgs, ... }:

{
  options.my.apps.konsole.enable = lib.mkEnableOption "Konsole terminal";

  config = lib.mkIf config.my.apps.konsole.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      konsole
    ];
  };
}
