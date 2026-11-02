{ ... }:

# Shared Home Manager defaults every user can import.
{
  imports = [
    ./git.nix
    ./shell
    ./editor.nix
    ./packages.nix
  ];
}
