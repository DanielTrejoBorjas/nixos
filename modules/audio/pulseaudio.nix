{ config, pkgs, ... }:

{
  assertions = [
    {
      assertion = !config.services.pipewire.enable;
      message = "modules/audio/pulseaudio.nix conflicts with pipewire.nix; import only one.";
    }
  ];

  security.rtkit.enable = true;

  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull; # Bluetooth codecs
  };
}
