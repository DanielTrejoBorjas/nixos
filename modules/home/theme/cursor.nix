{ config, lib, pkgs, ... }:

let
  themes = import ../../../lib/themes.nix { inherit lib; };
  theme = themes.resolve pkgs config.my.theme;
  cfg = config.my.theme.targets.cursor;
in
{
  options.my.theme.targets.cursor.enable = themes.mkTargetOption config "the theme's cursor for X11 and GTK";

  config = lib.mkIf (cfg.enable && config.my.theme.name != null) {
    home.pointerCursor = {
      inherit (theme.cursor) name package size;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
