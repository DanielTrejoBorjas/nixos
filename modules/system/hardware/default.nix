{ ... }:

# Generic hardware support, safe on any machine (including VMs).
# Device- and vendor-specific modules are opt-in per host via `my.hardware.*`.
{
  imports = [
    ./firmware.nix
    ./graphics.nix
    ./storage.nix
    ./input.nix

    ./bluetooth.nix
    ./laptop.nix
    ./fingerprint.nix
    ./logitech.nix
    ./realtek.nix

    ./amd
    ./intel
    ./nvidia
  ];
}
