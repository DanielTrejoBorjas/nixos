{ lib, ... }:

# Set by modules/nixos/theme for every user; a user can override it in home.nix.
{
  options.my.theme = (import ../../../lib/themes.nix { inherit lib; }).options;
}
