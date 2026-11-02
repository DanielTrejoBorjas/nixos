{ config, lib, ... }:

{
  config = lib.mkIf (config.my.virtualization.guest == "vmware") {
    virtualisation.vmware.guest.enable = true;
  };
}
