{ config, lib, pkgs, ... }:

let
  themes = import ../../../lib/themes.nix { inherit lib; };
  theme = themes.resolve pkgs config.my.theme;
  cfg = config.my.theme.targets.fonts;
  inherit (theme) fonts;
in
{
  options.my.theme.targets.fonts.enable = themes.mkTargetOption config "the theme's fonts as fontconfig defaults";

  config = lib.mkIf (cfg.enable && config.my.theme.name != null) {
    fonts.packages = lib.unique (map (f: f.package) [ fonts.sans fonts.serif fonts.monospace fonts.emoji ]);

    fonts.fontconfig.defaultFonts = {
      sansSerif = [ fonts.sans.name ];
      serif = [ fonts.serif.name ];
      monospace = [ fonts.monospace.name ];
      emoji = [ fonts.emoji.name ];
    };
  };
}
