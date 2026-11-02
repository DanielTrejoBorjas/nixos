{ config, lib, ... }:

{
  # Required system-wide for any user whose login shell is zsh.
  options.my.shell.zsh.enable = lib.mkEnableOption "zsh system-wide";

  config = lib.mkIf config.my.shell.zsh.enable {
    programs.zsh.enable = true;
  };
}
