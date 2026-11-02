# Shared by the NixOS and Home Manager theme modules so both accept the same `my.theme`.
{ lib }:

let
  dir = ../themes;

  names = map (lib.removeSuffix ".nix")
    (lib.filter (lib.hasSuffix ".nix") (lib.attrNames (builtins.readDir dir)));

  # Stop at derivations so an override replaces a package instead of merging into it.
  isLeaf = _: lhs: rhs:
    !(lib.isAttrs lhs && lib.isAttrs rhs) || lib.isDerivation lhs || lib.isDerivation rhs;
in
{
  options = {
    name = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum names);
      default = null;
      description = "Theme from themes/<name>.nix. null leaves appearance to the desktop environment.";
    };

    overrides = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      example = lib.literalExpression ''
        { cursor = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; }; fonts.size = 11; }
      '';
      description = "Merged over the selected theme to change single parts without writing a new theme.";
    };
  };

  mkTargetOption = config: description: lib.mkEnableOption description // {
    default = config.my.theme.name != null;
    defaultText = lib.literalExpression "config.my.theme.name != null";
  };

  resolve = pkgs: cfg:
    lib.recursiveUpdateUntil isLeaf (import (dir + "/${cfg.name}.nix") { inherit pkgs; }) cfg.overrides;
}
