{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/base.nix
    ../../profiles/plasma.nix

    ../../modules/virtualization/hyperv.nix
    ../../modules/services/ssh.nix
  ];

  networking.hostName = "hyperv";

  system.stateVersion = "25.11";
}
