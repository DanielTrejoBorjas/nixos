{ config, lib, ... }:

{
  config = lib.mkIf (config.my.virtualization.guest == "qemu") {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
