{ ... }:

{
  services.displayManager.sddm = {
    enable = true;
    # Set to false (and pick the X11 session) if Plasma misbehaves on Hyper-V.
    wayland.enable = true;
  };

  services.displayManager.defaultSession = "plasma";
}
