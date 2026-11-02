{ config, lib, ... }:

let
  cfg = config.my.hardware.nvidia;
in
{
  config = lib.mkIf (cfg.enable && cfg.driver == "nouveau") {
    boot.initrd.kernelModules = [ "nouveau" ];
    services.xserver.videoDrivers = [ "nouveau" ];
  };
}
