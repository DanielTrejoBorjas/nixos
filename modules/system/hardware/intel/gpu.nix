{ config, lib, pkgs, ... }:

let
  cfg = config.my.hardware.intel.gpu;
in
{
  options.my.hardware.intel.gpu.enable = lib.mkEnableOption "Intel integrated graphics (VA-API/QSV)";

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver # iHD: Broadwell and newer
      intel-vaapi-driver # i965: older iGPUs
      vpl-gpu-rt         # QuickSync on Tiger Lake and newer
      intel-compute-runtime # OpenCL
    ];

    environment.sessionVariables.LIBVA_DRIVER_NAME = lib.mkDefault "iHD";
  };
}
