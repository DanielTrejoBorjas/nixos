{ ... }:

{
  # UEFI only (use a Generation 2 VM in Hyper-V)
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
