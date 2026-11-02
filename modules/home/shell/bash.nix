{ config, lib, ... }:

{
  options.my.shell.bash.enable = lib.mkEnableOption "bash managed by Home Manager";

  config = lib.mkIf config.my.shell.bash.enable {
    programs.bash = {
      enable = true;
      historyControl = [ "ignoredups" "ignorespace" ];
    };
  };
}
