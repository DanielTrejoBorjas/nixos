{ config, lib, pkgs, ... }:

{
  options.my.apps.ark.enable = lib.mkEnableOption "Ark archive manager";

  config = lib.mkIf config.my.apps.ark.enable {
    environment.systemPackages = with pkgs.kdePackages; [
      ark
    ];
  };
}
