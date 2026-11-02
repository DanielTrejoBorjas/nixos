{ config, lib, ... }:

let
  cfg = config.my.hardware.realtek;
  kp = config.boot.kernelPackages;
in
{
  options.my.hardware.realtek = {
    enable = lib.mkEnableOption "Realtek NIC, Wi-Fi and Bluetooth support";

    extraDrivers = lib.mkOption {
      type = lib.types.listOf (lib.types.enum [ "r8168" "rtl8821cu" "rtl8812au" "rtl88x2bu" "rtl8814au" ]);
      default = [ ];
      example = [ "r8168" "rtl8821cu" ];
      description = ''
        Out-of-tree kernel modules for hardware the in-kernel drivers handle
        poorly (r8168 for some RTL8111/8168 NICs, USB Wi-Fi dongles).
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = map (d: kp.${d}) cfg.extraDrivers;

    # r8168 must win over the in-kernel r8169 for the same device.
    boot.blacklistedKernelModules = lib.optional (builtins.elem "r8168" cfg.extraDrivers) "r8169";
  };
}
