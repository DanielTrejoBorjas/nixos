{ ... }:

# Bare minimum for a working, bootable, reachable system.
# Optional features live in modules/{audio,desktop,services,programs,virtualization},
# grouped into profiles/, and are enabled per host. Accounts live in users/.
{
  imports = [
    ./nix.nix
    ./boot
    ./kernel
    ./hardware
    ./memory.nix
    ./network.nix
    ./locale.nix
    ./security.nix
    ./journal.nix
  ];
}
