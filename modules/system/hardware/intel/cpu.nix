{ config, lib, ... }:

let
  cfg = config.my.hardware.intel.cpu;
in
{
  options.my.hardware.intel.cpu.enable = lib.mkEnableOption "Intel CPU tuning (thermald, KVM)";

  config = lib.mkIf cfg.enable {
    services.thermald.enable = true;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
