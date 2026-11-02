{ config, lib, pkgs, ... }:

let
  cfg = config.my.packages.tools;
in
{
  options.my.packages.tools = {
    enable = lib.mkEnableOption "basic system-wide CLI tools";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ vim wget curl htop tree unzip ];
      defaultText = lib.literalExpression "with pkgs; [ vim wget curl htop tree unzip ]";
      description = "Packages in the group; override to add or drop tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = cfg.packages;
  };
}
