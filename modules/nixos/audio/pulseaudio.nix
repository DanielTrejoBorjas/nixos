{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.my.audio.backend == "pulseaudio") {
    security.rtkit.enable = true;

    services.pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull; # Bluetooth codecs
    };
  };
}
