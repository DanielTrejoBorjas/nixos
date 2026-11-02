{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/base.nix
    ../../profiles/plasma.nix
    ../../profiles/plasma-apps.nix

    ../../modules/audio/pipewire.nix
    ../../modules/virtualization/guests/hyperv.nix
    ../../modules/services/ssh.nix
  ];

  networking.hostName = "hyperv";

  system.stateVersion = "25.11";
}
