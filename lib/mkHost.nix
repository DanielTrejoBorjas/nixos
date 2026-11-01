# Builds a nixosSystem from hosts/<host> and the given users.
# Each name in `users` needs users/<name>/{default,home}.nix.
{ nixpkgs, home-manager, inputs }:

{ host, users, system ? "x86_64-linux" }:

nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };
  modules = [
    ../hosts/${host}

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.users = nixpkgs.lib.genAttrs users (u: import ../users/${u}/home.nix);
    }
  ] ++ map (u: ../users/${u}) users;
}
