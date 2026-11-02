# NixOS configuration

Flake-based NixOS + Home Manager setup, currently targeting a Hyper-V VM (`hyperv`).

```
flake.nix                  inputs + list of hosts
lib/mkHost.nix             builds a host from hosts/<host> and its users
hosts/<host>/              machine-specific: hostname, stateVersion, hardware, chosen profiles
profiles/                  bundles of modules that hosts import
  base.nix                   minimal system + CLI programs
  plasma.nix                 SDDM + minimal Plasma (no apps, no audio)
  plasma-apps.nix            Plasma applications + Firefox
modules/
  system/                  minimum to run: nix, boot, kernel, memory, network, locale, security, journal
    hardware/                generic (firmware, graphics, storage, input) + opt-in my.hardware.*
  audio/                   pipewire | pulseaudio (import exactly one)
  desktop/                 sddm, plasma/ (minimal), plasma/apps/<app>.nix (one module each)
  services/                ssh, avahi, printing, flatpak, tailscale, fail2ban
  programs/                shell, git, firefox, tools
  virtualization/          docker, guests/{hyperv,qemu,vmware,virtualbox}
  home/                    shared Home Manager modules users import
users/<name>/              default.nix (system account) + home.nix (Home Manager)
```

Layers, from generic to specific: `modules` (single features) -> `profiles` (bundles) -> `hosts` (machine) -> `users` (people).

## Usage

```sh
rebuild            # alias: sudo nixos-rebuild switch --flake . (run from the repo)
rebuild hyperv     # explicit host
```

## Options

Modules without options are enabled by importing them. Configurable ones live under `my.*`:

| Option | Default |
| --- | --- |
| `my.boot.loader` (`systemd-boot`, `grub`), `my.boot.generationLimit` | `systemd-boot`, `10` |
| `my.kernel.variant` (`lts`, `latest`, `zen`, `hardened`) | `lts` |
| `my.locale.{timeZone,language,keyboardLayout}` | Madrid, `es_ES.UTF-8`, `es` |
| `my.hardware.{bluetooth,laptop,fingerprint,logitech,realtek}.enable` | off |
| `my.hardware.intel.{cpu,gpu}.enable`, `my.hardware.amd.{cpu,gpu}.enable` | off |
| `my.hardware.nvidia.{enable,driver,variant,open,prime.*}` | off |

## Adding a host

1. Create `hosts/<name>/default.nix`: import `./hardware-configuration.nix`, the profiles, an audio module and extra modules it needs; set hostName, stateVersion and any `my.*` options.
2. Add `<name> = mkHost { host = "<name>"; users = [ "daniel" ]; };` to `nixosConfigurations` in `flake.nix`.

## Adding a user

1. Copy `users/daniel/` to `users/<newuser>/` and edit `default.nix` (account, groups, shell) and `home.nix` (username, home directory, git identity).
2. Add `"<newuser>"` to the `users` list of the hosts that should have them in `flake.nix`.

## Adding a feature

Create a module in the matching `modules/` folder, then import it from a profile (shared by many hosts) or directly from a host.

Flakes ignore untracked files: `git add` new files before rebuilding.
