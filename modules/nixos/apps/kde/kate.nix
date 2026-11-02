{ config, lib, pkgs, ... }:

{
  options.my.apps.kate.enable = lib.mkEnableOption "Kate text editor";

  config = lib.mkIf config.my.apps.kate.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      kate
    ];
  };
}
