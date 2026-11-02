{ pkgs }:

{
  fonts = {
    sans = { name = "Noto Sans"; package = pkgs.noto-fonts; };
    serif = { name = "Noto Serif"; package = pkgs.noto-fonts; };
    monospace = { name = "Hack"; package = pkgs.hack-font; };
    emoji = { name = "Noto Color Emoji"; package = pkgs.noto-fonts-color-emoji; };
    size = 10;
  };

  gtk = { name = "Breeze"; package = pkgs.kdePackages.breeze-gtk; };
  icons = { name = "breeze-dark"; package = pkgs.kdePackages.breeze-icons; };
  cursor = { name = "breeze_cursors"; package = pkgs.kdePackages.breeze; size = 24; };

  plasma = {
    colorScheme = { name = "BreezeDark"; package = pkgs.kdePackages.breeze; };
    lookAndFeel = "org.kde.breezedark.desktop";
    widgetStyle = "Breeze";
  };

  terminal = {
    background = "#232627";
    foreground = "#fcfcfc";
    normal = [ "#232627" "#ed1515" "#11d116" "#f67400" "#1d99f3" "#9b59b6" "#1abc9c" "#fcfcfc" ];
    bright = [ "#7f8c8d" "#c0392b" "#1cdc9a" "#fdbc4b" "#3daee9" "#8e44ad" "#16a085" "#ffffff" ];
  };
}
