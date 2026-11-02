# NixOS configuration

Flake-based NixOS + Home Manager setup, currently targeting a Hyper-V VM (`hyperv`).

Every module is imported automatically and does nothing until a `my.*` option enables it.
A host turns features on in one file; profiles enable common groups with `mkDefault`,
so any single part can still be switched off.

```
flake.nix                  inputs + list of hosts
lib/                       mkHost, importTree (auto-import), themes (theme loading)
hosts/<host>/              central control: profiles, toggles, theme, hardware
users/<name>/              default.nix (system account) + home.nix (Home Manager toggles)
themes/<name>.nix          theme data: fonts, GTK, icons, cursor, Plasma, terminal colours
modules/nixos/             NixOS modules: system, hardware, audio, desktop, apps, shell,
                           packages, services, virtualization, theme, profiles
modules/home/              Home Manager modules: git, editor, shell, packages, theme
```

## Usage

```sh
rebuild            # alias: sudo nixos-rebuild switch --flake . (run from the repo)
rebuild hyperv     # explicit host
```

```nix
# hosts/hyperv/default.nix
my.apps.kate.enable = false;          # drop one app from a profile
my.services.tailscale.enable = true;  # add a service
my.theme.name = "breeze-dark";        # switch theme
```

See [docs/architecture.md](docs/architecture.md) for every option, how themes work
and how to add hosts, users and modules.

Flakes ignore untracked files: `git add` new files before rebuilding.
