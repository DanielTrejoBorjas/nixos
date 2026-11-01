# NixOS configuration

Flake-based NixOS + Home Manager setup, currently targeting a Hyper-V VM (`hyperv`).

```
flake.nix                  inputs + list of hosts
lib/mkHost.nix             builds a host from hosts/<host> and its users
hosts/<host>/              machine-specific: hostname, stateVersion, hardware, chosen profiles
profiles/                  bundles of modules (base, plasma, ...) that hosts import
modules/
  system/                  minimum to run: nix, boot/, kernel/, hardware/, network, locale
  desktop/                 sddm, plasma, audio
  services/                ssh
  programs/                shell, git, browser, tools
  virtualization/          hyperv
  home/                    shared Home Manager modules users import
users/<name>/              default.nix (system account) + home.nix (Home Manager)
sync.sh                    pull, regenerate hardware config, nixos-rebuild
```

Layers, from generic to specific: `modules` (single features) -> `profiles` (bundles) -> `hosts` (machine) -> `users` (people).

## Usage

```sh
./sync.sh            # uses the machine's hostname
./sync.sh hyperv     # explicit host
./sync.sh --boot     # apply on next reboot
```

## Adding a host

1. Create `hosts/<name>/default.nix`: import `./hardware-configuration.nix`, the profiles and extra modules it needs; set hostName and stateVersion.
2. Add `<name> = mkHost { host = "<name>"; users = [ "daniel" ]; };` to `nixosConfigurations` in `flake.nix`.
3. Run `./sync.sh <name>`.

## Adding a user

1. Copy `users/daniel/` to `users/<newuser>/` and edit `default.nix` (account, groups, shell) and `home.nix` (username, home directory, git identity).
2. Add `"<newuser>"` to the `users` list of the hosts that should have them in `flake.nix`.

## Adding a feature

Create a module in the matching `modules/` folder, then import it from a profile (shared by many hosts) or directly from a host.

Flakes ignore untracked files: `git add` new files before rebuilding.
