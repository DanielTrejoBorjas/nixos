{ config, lib, ... }:

let
  themes = import ../../../lib/themes.nix { inherit lib; };
  cfg = config.my.theme;
in
{
  options.my.theme = themes.options;

  # Hands the selection to every Home Manager user; users can still override it.
  config = lib.mkIf (cfg.name != null) {
    home-manager.sharedModules = [
      {
        my.theme = {
          name = lib.mkDefault cfg.name;
          overrides = lib.mkDefault cfg.overrides;

          # Plasma rewrites the GTK settings and cursor files itself; Home Manager owning them breaks activation.
          targets = lib.mkIf config.my.desktop.plasma.enable {
            gtk.enable = lib.mkDefault false;
            cursor.enable = lib.mkDefault false;
          };
        };
      }
    ];
  };
}
