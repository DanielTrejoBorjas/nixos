{ config, lib, ... }:

{
  options.my.shell.zsh.enable = lib.mkEnableOption "zsh managed by Home Manager";

  config = lib.mkIf config.my.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        size = 10000;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
      };
    };
  };
}
