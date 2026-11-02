{ config, lib, ... }:

let
  cfg = config.my.editor;
in
{
  options.my.editor = {
    enable = lib.mkEnableOption "EDITOR/VISUAL session variables";

    command = lib.mkOption {
      type = lib.types.str;
      default = "vim";
      description = "Editor command; it must be installed separately (vim comes from my.packages.tools).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = cfg.command;
      VISUAL = cfg.command;
    };
  };
}
