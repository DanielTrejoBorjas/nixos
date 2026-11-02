{ config, lib, ... }:

{
  options.my.apps.git.enable = lib.mkEnableOption "system-wide git";

  config = lib.mkIf config.my.apps.git.enable {
    programs.git.enable = true;
  };
}
