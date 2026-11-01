{ ... }:

# What every host gets: the minimal system plus basic CLI programs.
{
  imports = [
    ../modules/system
    ../modules/programs/shell.nix
    ../modules/programs/git.nix
    ../modules/programs/tools.nix
  ];
}
