{ config, lib, ... }:

{
  options.my.virtualization.docker.enable = lib.mkEnableOption "Docker with automatic pruning";

  config = lib.mkIf config.my.virtualization.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };
}
