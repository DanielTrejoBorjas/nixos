{ config, lib, ... }:

let
  cfg = config.my.hardware.nvidia;
in
{
  config = lib.mkIf (cfg.enable && cfg.driver == "proprietary") {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.${cfg.variant};
      open = cfg.open;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };

    hardware.nvidia.prime = lib.mkIf cfg.prime.enable ({
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = cfg.prime.nvidiaBusId;
    }
    // lib.optionalAttrs (cfg.prime.intelBusId != "") { intelBusId = cfg.prime.intelBusId; }
    // lib.optionalAttrs (cfg.prime.amdgpuBusId != "") { amdgpuBusId = cfg.prime.amdgpuBusId; });
  };
}
