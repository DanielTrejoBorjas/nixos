{ lib, ... }:

{
  options.my.boot = {
    loader = lib.mkOption {
      type = lib.types.enum [ "systemd-boot" "grub" ];
      default = "systemd-boot";
      description = "Boot loader (both UEFI; use a Generation 2 VM in Hyper-V).";
    };

    generationLimit = lib.mkOption {
      type = lib.types.ints.positive;
      default = 10;
      description = "Boot entries kept in the loader menu.";
    };
  };

  config = {
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = lib.mkDefault 3;
    boot.tmp.cleanOnBoot = true;
  };
}
