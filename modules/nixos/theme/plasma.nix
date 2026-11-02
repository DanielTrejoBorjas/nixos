{ config, lib, pkgs, ... }:

let
  themes = import ../../../lib/themes.nix { inherit lib; };
  theme = themes.resolve pkgs config.my.theme;
  cfg = config.my.theme.targets.plasma;

  inherit (theme) fonts plasma;
  fontSpec = font: "${font.name},${toString fonts.size}";

  settings = pkgs.writeText "kdeglobals-theme" (lib.generators.toINI { } {
    General = {
      ColorScheme = plasma.colorScheme.name;
      font = fontSpec fonts.sans;
      fixed = fontSpec fonts.monospace;
    };
    Icons.Theme = theme.icons.name;
    KDE = {
      LookAndFeelPackage = plasma.lookAndFeel;
      widgetStyle = plasma.widgetStyle;
    };
  });

  # Apps read colours from kdeglobals itself, so the scheme's colour groups go in too.
  colorScheme = "${plasma.colorScheme.package}/share/color-schemes/${plasma.colorScheme.name}.colors";
in
{
  options.my.theme.targets.plasma.enable = lib.mkEnableOption "the theme as Plasma's system-wide appearance defaults" // {
    default = config.my.theme.name != null && config.my.desktop.plasma.enable;
    defaultText = lib.literalExpression "config.my.theme.name != null && config.my.desktop.plasma.enable";
  };

  # /etc/xdg holds defaults only: anything a user sets in System Settings (~/.config) still wins.
  config = lib.mkIf (cfg.enable && config.my.theme.name != null) {
    environment.etc."xdg/kdeglobals".source = pkgs.concatText "kdeglobals" [ colorScheme settings ];

    environment.etc."xdg/kcminputrc".text = lib.generators.toINI { } {
      Mouse = {
        cursorTheme = theme.cursor.name;
        cursorSize = theme.cursor.size;
      };
    };

    environment.systemPackages = [ theme.icons.package theme.cursor.package ];
  };
}
