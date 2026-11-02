{ config, lib, pkgs, ... }:

let
  cfg = config.my.hardware.amd.gpu;
in
{
  options.my.hardware.amd.gpu = {
    enable = lib.mkEnableOption "AMD GPU support (amdgpu, Mesa, VA-API)";
    rocm = lib.mkEnableOption "ROCm/OpenCL compute support";
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.amdgpu.initrd.enable = true;

    hardware.graphics.extraPackages = lib.mkIf cfg.rocm [
      pkgs.rocmPackages.clr.icd
    ];
  };
}
