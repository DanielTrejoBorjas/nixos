{ config, lib, pkgs, ... }:

let
  cfg = config.my.packages.cli;
in
{
  options.my.packages.cli = {
    enable = lib.mkEnableOption "per-user CLI tools";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ ripgrep fd jq ];
      defaultText = lib.literalExpression "with pkgs; [ ripgrep fd jq ]";
      description = "Packages in the group; override to add or drop tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = cfg.packages;
  };
}
