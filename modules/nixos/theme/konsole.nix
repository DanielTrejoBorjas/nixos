{ config, lib, pkgs, ... }:

let
  themes = import ../../../lib/themes.nix { inherit lib; };
  theme = themes.resolve pkgs config.my.theme;
  cfg = config.my.theme.targets.konsole;

  id = "nix-theme";
  inherit (theme) terminal;

  ansi = suffix: colors: lib.listToAttrs
    (lib.imap0 (i: color: lib.nameValuePair "Color${toString i}${suffix}" { Color = color; }) colors);

  colorScheme = pkgs.writeTextDir "share/konsole/${id}.colorscheme" (lib.generators.toINI { } ({
    General = { Description = "Nix theme"; Opacity = 1; };
    Background.Color = terminal.background;
    BackgroundIntense.Color = terminal.background;
    Foreground.Color = terminal.foreground;
    ForegroundIntense.Color = terminal.foreground;
  } // ansi "" terminal.normal // ansi "Intense" terminal.bright));

  profile = pkgs.writeTextDir "share/konsole/${id}.profile" (lib.generators.toINI { } {
    General = { Name = "Nix theme"; Parent = "FALLBACK/"; };
    Appearance = {
      ColorScheme = id;
      Font = "${theme.fonts.monospace.name},${toString theme.fonts.size}";
    };
  });
in
{
  options.my.theme.targets.konsole.enable = themes.mkTargetOption config "the theme's terminal colours and font as Konsole's default profile";

  # Profile and scheme are found through XDG data dirs; konsolerc in /etc/xdg is only a default.
  config = lib.mkIf (cfg.enable && config.my.theme.name != null) {
    environment.systemPackages = [ colorScheme profile ];
    environment.pathsToLink = [ "/share/konsole" ];

    environment.etc."xdg/konsolerc".text = lib.generators.toINI { } {
      "Desktop Entry".DefaultProfile = "${id}.profile";
    };
  };
}
