{ pkgs, ... }:

{
  # Default (LTS) kernel. Swap for pkgs.linuxPackages_latest if needed.
  boot.kernelPackages = pkgs.linuxPackages;
}
