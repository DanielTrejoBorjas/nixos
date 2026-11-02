{ config, lib, ... }:

{
  options.my.shell.bash.enable = lib.mkEnableOption "bash completion system-wide";

  config = lib.mkIf config.my.shell.bash.enable {
    programs.bash.completion.enable = true;
  };
}
