{ config, lib, ... }:

{
  config = lib.mkIf (config.my.virtualization.guest == "virtualbox") {
    virtualisation.virtualbox.guest.enable = true;
  };
}
