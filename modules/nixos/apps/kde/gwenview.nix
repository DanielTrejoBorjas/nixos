{ config, lib, pkgs, ... }:

{
  options.my.apps.gwenview.enable = lib.mkEnableOption "Gwenview image viewer";

  config = lib.mkIf config.my.apps.gwenview.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      gwenview
    ];
  };
}
