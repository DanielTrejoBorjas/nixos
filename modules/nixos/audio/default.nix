{ lib, ... }:

{
  # An enum rather than two toggles, so two sound servers can never be enabled together.
  options.my.audio.backend = lib.mkOption {
    type = lib.types.enum [ "none" "pipewire" "pulseaudio" ];
    default = "none";
    description = "Sound server.";
  };
}
