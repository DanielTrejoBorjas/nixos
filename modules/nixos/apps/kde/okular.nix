{ config, lib, pkgs, ... }:

{
  options.my.apps.okular.enable = lib.mkEnableOption "Okular document viewer";

  config = lib.mkIf config.my.apps.okular.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      okular
    ];
  };
}
