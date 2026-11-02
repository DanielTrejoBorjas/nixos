{ config, lib, ... }:

# Unfree itself is allowed globally in ../nix.nix.
{
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # The kernel only loads the microcode matching the CPU, so both are harmless on VMs.
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.fwupd.enable = true;
}
