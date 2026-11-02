{ config, lib, ... }:

let
  cfg = config.my.hardware.amd.cpu;
in
{
  options.my.hardware.amd.cpu.enable = lib.mkEnableOption "AMD CPU tuning (amd-pstate, KVM)";

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "amd_pstate=active" ];
    boot.kernelModules = [ "kvm-amd" ];
  };
}
