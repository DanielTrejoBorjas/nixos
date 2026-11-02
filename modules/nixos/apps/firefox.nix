{ config, lib, ... }:

{
  options.my.apps.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf config.my.apps.firefox.enable {
    programs.firefox.enable = true;
  };
}
