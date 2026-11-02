{ lib, ... }:

{
  options.my.virtualization.guest = lib.mkOption {
    type = lib.types.enum [ "none" "hyperv" "qemu" "vmware" "virtualbox" ];
    default = "none";
    description = "Hypervisor this machine runs under, for guest integration. none on bare metal.";
  };
}
