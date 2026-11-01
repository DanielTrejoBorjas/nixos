{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkHost = import ./lib/mkHost.nix { inherit nixpkgs home-manager inputs; };
    in
    {
      nixosConfigurations = {
        hyperv = mkHost { host = "hyperv"; users = [ "daniel" ]; };
      };
    };
}
