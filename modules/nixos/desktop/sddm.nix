{ config, lib, ... }:

let
  cfg = config.my.desktop.sddm;
in
{
  # The default session is set by the desktop module (plasma6 sets it to "plasma").
  options.my.desktop.sddm.enable = lib.mkEnableOption "the SDDM display manager";

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      # Set to false (and pick the X11 session) if Plasma misbehaves on Hyper-V.
      wayland.enable = true;
    };
  };
}
