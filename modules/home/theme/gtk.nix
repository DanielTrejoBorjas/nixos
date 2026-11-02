{ config, lib, pkgs, ... }:

let
  themes = import ../../../lib/themes.nix { inherit lib; };
  theme = themes.resolve pkgs config.my.theme;
  cfg = config.my.theme.targets.gtk;
in
{
  options.my.theme.targets.gtk.enable = themes.mkTargetOption config "the theme's GTK theme, icons and font";

  config = lib.mkIf (cfg.enable && config.my.theme.name != null) {
    gtk = {
      enable = true;
      theme = { inherit (theme.gtk) name package; };
      iconTheme = { inherit (theme.icons) name package; };
      font = {
        inherit (theme.fonts.sans) name package;
        size = theme.fonts.size;
      };
    };
  };
}
