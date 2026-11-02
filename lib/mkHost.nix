# Builds a nixosSystem from hosts/<host> and the given users.
# Each name in `users` needs users/<name>/{default,home}.nix.
# All modules are imported; they stay inert until their `my.*` options enable them.
{ nixpkgs, home-manager, inputs }:

{ host, users, system ? "x86_64-linux" }:

let
  inherit (nixpkgs) lib;
  importTree = import ./importTree.nix lib;
in
lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = importTree ../modules/nixos ++ [
    ../hosts/${host}

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.sharedModules = importTree ../modules/home;
      home-manager.users = lib.genAttrs users (u: import ../users/${u}/home.nix);
    }
  ] ++ map (u: ../users/${u}) users;
}
