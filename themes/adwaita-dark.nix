{ pkgs }:

{
  fonts = {
    sans = { name = "Cantarell"; package = pkgs.cantarell-fonts; };
    serif = { name = "Noto Serif"; package = pkgs.noto-fonts; };
    monospace = { name = "Source Code Pro"; package = pkgs.source-code-pro; };
    emoji = { name = "Noto Color Emoji"; package = pkgs.noto-fonts-color-emoji; };
    size = 11;
  };

  gtk = { name = "Adwaita-dark"; package = pkgs.gnome-themes-extra; };
  icons = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; };
  cursor = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; size = 24; };

  # No maintained Adwaita style for Qt 6; Breeze Dark is the closest match.
  plasma = {
    colorScheme = { name = "BreezeDark"; package = pkgs.kdePackages.breeze; };
    lookAndFeel = "org.kde.breezedark.desktop";
    widgetStyle = "Breeze";
  };

  terminal = {
    background = "#1e1e1e";
    foreground = "#ffffff";
    normal = [ "#241f31" "#c01c28" "#2ec27e" "#f5c211" "#1e78e4" "#9841bb" "#0ab9dc" "#c0bfbc" ];
    bright = [ "#5e5c64" "#ed333b" "#57e389" "#f8e45c" "#51a1ff" "#c061cb" "#4fd2fd" "#f6f5f4" ];
  };
}
