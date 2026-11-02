{ config, lib, ... }:

let
  cfg = config.my.hardware.graphics;
in
{
  options.my.hardware.graphics.enable = lib.mkEnableOption "OpenGL/Vulkan with 32-bit support";

  config = lib.mkIf cfg.enable {
    # 32-bit for Steam/Wine.
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
