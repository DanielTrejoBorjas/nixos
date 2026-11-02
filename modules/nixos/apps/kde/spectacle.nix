{ config, lib, pkgs, ... }:

{
  options.my.apps.spectacle.enable = lib.mkEnableOption "Spectacle screenshot tool";

  config = lib.mkIf config.my.apps.spectacle.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      spectacle
    ];
  };
}
