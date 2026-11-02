{ config, lib, ... }:

{
  config = lib.mkIf (config.my.virtualization.guest == "hyperv") {
    # Hyper-V guest integration (clipboard/shutdown/time sync, video, etc.)
    virtualisation.hypervGuest.enable = true;
  };
}
