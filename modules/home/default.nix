{ ... }:

# Shared Home Manager defaults every user can import.
{
  imports = [
    ./git.nix
    ./shell.nix
    ./packages.nix
  ];
}
