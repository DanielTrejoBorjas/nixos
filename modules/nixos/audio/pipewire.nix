{ config, lib, ... }:

{
  config = lib.mkIf (config.my.audio.backend == "pipewire") {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
