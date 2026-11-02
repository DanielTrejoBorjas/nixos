{ config, lib, ... }:

let
  cfg = config.my.hardware.firmware;
in
{
  # enableAllFirmware needs unfree packages, allowed by my.system.nix.
  options.my.hardware.firmware.enable = lib.mkEnableOption "all firmware, CPU microcode and fwupd";

  config = lib.mkIf cfg.enable {
    hardware.enableRedistributableFirmware = true;
    hardware.enableAllFirmware = true;

    # The kernel only loads the microcode matching the CPU, so both are harmless on VMs.
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    services.fwupd.enable = true;
  };
}
