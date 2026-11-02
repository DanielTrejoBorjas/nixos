# Architecture

## Layers

```
modules  ->  profiles  ->  hosts  ->  users
(atoms)      (bundles)     (machine)  (people)
```

- **Modules** (`modules/nixos`, `modules/home`): one responsibility each. Every file declares
  its own `my.*` option and wraps its config in `lib.mkIf`, so importing it changes nothing.
- **Profiles** (`modules/nixos/profiles`): options that set groups of module toggles with
  `lib.mkDefault`. A plain assignment in a host always wins over them.
- **Hosts** (`hosts/<host>/default.nix`): the central control file. It picks profiles, turns
  individual modules on or off, and chooses audio, guest integration and theme.
- **Users** (`users/<name>/`): `default.nix` holds the system account; `home.nix` holds that
  user's Home Manager toggles and identity.

`lib/mkHost.nix` imports every `.nix` file under `modules/nixos` into the system and every
file under `modules/home` into each Home Manager user (`lib/importTree.nix`). There are no
import lists to maintain.

## Directory structure

```
modules/nixos/
  system/          nix, memory, network, security, journal, locale, kernel, boot/
  hardware/        firmware, graphics, storage, input, bluetooth, laptop, fingerprint,
                   logitech, realtek, amd/, intel/, nvidia/
  audio/           backend enum + pipewire, pulseaudio
  desktop/         sddm, plasma
  apps/            firefox, git, kde/<app>
  shell/           zsh, bash (system side)
  packages/        tools (package group)
  services/        ssh, avahi, printing, flatpak, tailscale, fail2ban
  virtualization/  docker, guests/ (guest enum + hyperv, qemu, vmware, virtualbox)
  theme/           selection + targets: fonts, plasma, konsole
  profiles/        base, plasma, plasma-apps
modules/home/
  git, editor, shell/{aliases,bash,zsh}, packages/cli, theme/ (selection + gtk, cursor)
themes/            breeze, breeze-dark, adwaita-dark
```

## System options (`my.*` in a host)

| Option | Default | Notes |
| --- | --- | --- |
| `profiles.base.enable` | off | `system.*`, generic `hardware.*`, `shell.{zsh,bash}`, `apps.git`, `packages.tools` |
| `profiles.plasma.enable` | off | `desktop.sddm`, `desktop.plasma` |
| `profiles.plasma-apps.enable` | off | ark, dolphin, gwenview, kate, kcalc, konsole, okular, spectacle, firefox |
| `system.{nix,memory,network,security,journal}.enable` | off | |
| `boot.loader` (`systemd-boot`, `grub`), `boot.generationLimit` | `systemd-boot`, `10` | always applied |
| `kernel.variant` (`lts`, `latest`, `zen`, `hardened`) | `lts` | always applied |
| `locale.{timeZone,language,keyboardLayout}` | Madrid, `es_ES.UTF-8`, `es` | always applied |
| `hardware.{firmware,graphics,storage,input}.enable` | off | |
| `hardware.{bluetooth,laptop,fingerprint,logitech,realtek}.enable` | off | `realtek.extraDrivers` |
| `hardware.{intel,amd}.{cpu,gpu}.enable` | off | `amd.gpu.rocm` |
| `hardware.nvidia.{enable,driver,variant,open,prime.*}` | off | |
| `audio.backend` (`none`, `pipewire`, `pulseaudio`) | `none` | an enum, so two servers can't both be enabled |
| `desktop.{sddm,plasma}.enable` | off | |
| `apps.<name>.enable` | off | firefox, git, ark, dolphin, elisa, gwenview, kate, kcalc, kdeconnect, konsole, okular, spectacle |
| `shell.{zsh,bash}.enable` | off | system-wide zsh / bash completion |
| `packages.tools.{enable,packages}` | off | vim, wget, curl, htop, tree, unzip |
| `services.<name>.enable` | off | ssh, avahi, printing, flatpak, tailscale, fail2ban |
| `virtualization.docker.enable` | off | |
| `virtualization.guest` (`none`, `hyperv`, `qemu`, `vmware`, `virtualbox`) | `none` | |
| `theme.{name,overrides}`, `theme.targets.{fonts,plasma,konsole}.enable` | `null` | see Themes |

## Home Manager options (`my.*` in `users/<name>/home.nix`)

| Option | Notes |
| --- | --- |
| `git.enable` | shared defaults; identity is set per user |
| `editor.{enable,command}` | `EDITOR`/`VISUAL`, default `vim` |
| `shell.{aliases,bash,zsh}.enable` | |
| `packages.cli.{enable,packages}` | ripgrep, fd, jq |
| `theme.targets.{gtk,cursor}.enable` | see Themes |

## Seeing what is enabled

```sh
nix eval .#nixosConfigurations.hyperv.config.my --json | jq
nix eval .#nixosConfigurations.hyperv.config.home-manager.users.daniel.my --json | jq
```

## Enabling and disabling

Edit only the host (system) or `home.nix` (user):

```nix
# hosts/hyperv/default.nix
my = {
  profiles.plasma-apps.enable = true;
  apps.kate.enable = false;            # overrides the profile's mkDefault
  apps.elisa.enable = true;            # not in any profile
  services.printing.enable = true;     # also turns on avahi (mkDefault)
  services.avahi.enable = false;       # ...unless you say otherwise
  audio.backend = "pulseaudio";
  packages.tools.packages = with pkgs; [ vim curl ];   # needs `pkgs` in the host's arguments
};
```

```nix
# users/daniel/home.nix
my.shell.bash.enable = false;
my.packages.cli.packages = with pkgs; [ ripgrep fd jq bat ];
```

Native NixOS options still work and can be set next to the toggles, for example
`services.displayManager.sddm.wayland.enable = false;`.

## Themes

`my.theme.name` selects `themes/<name>.nix`. `null` (the default) applies nothing and leaves
appearance to Plasma. The selection is handed to every Home Manager user automatically.

A theme is plain data:

```nix
{ pkgs }:
{
  fonts = { sans = { name; package; }; serif; monospace; emoji; size; };
  gtk = { name; package; };
  icons = { name; package; };
  cursor = { name; package; size; };
  plasma = { colorScheme = { name; package; }; lookAndFeel; widgetStyle; };
  terminal = { background; foreground; normal = [ 8 colours ]; bright = [ 8 colours ]; };
}
```

Targets read the theme and apply one part each. Each target turns itself on when a theme is
selected and can be turned off on its own:

| Target | Side | Applies | Default when a theme is set |
| --- | --- | --- | --- |
| `fonts` | NixOS | font packages + fontconfig defaults | on |
| `plasma` | NixOS | colour scheme, look-and-feel, widget style, icons, fonts, cursor in `/etc/xdg` | on if `desktop.plasma` |
| `konsole` | NixOS | colour scheme + default profile (colours, monospace font) | on |
| `gtk` | Home Manager | GTK theme, icons, font | off under Plasma |
| `cursor` | Home Manager | X11/GTK cursor | off under Plasma |

The Plasma and Konsole targets write **system defaults** in `/etc/xdg`. Anything already set
in a user's `~/.config/kdeglobals`, `kcminputrc` or `konsolerc` (for example from System
Settings) still wins. Delete those keys to fall back to the theme. `gtk` and `cursor` are off
under Plasma because Plasma rewrites those files itself, which breaks Home Manager activation.

Switch or tweak a theme:

```nix
my.theme.name = "breeze-dark";
my.theme.overrides = {
  fonts.size = 11;
  cursor = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; };
};
my.theme.targets.konsole.enable = false;
```

Add a theme: copy a file in `themes/`, change the values, `git add` it. The name becomes
valid for `my.theme.name` automatically.

Plasma wallpapers aren't covered. Plasma keeps them per user in a file it rewrites, with no
system default to set. Managing them declaratively would need the `plasma-manager` flake input.

## Adding things

**A module.** Create a file in the matching `modules/nixos` (or `modules/home`) folder and
`git add` it. Nothing else to edit:

```nix
# modules/nixos/apps/vlc.nix
{ config, lib, pkgs, ... }:

{
  options.my.apps.vlc.enable = lib.mkEnableOption "VLC media player";

  config = lib.mkIf config.my.apps.vlc.enable {
    environment.systemPackages = [ pkgs.vlc ];
  };
}
```

**Mutually exclusive choices** (audio, guest, boot loader): one `default.nix` declares an enum,
and each implementation file does `lib.mkIf (config.my.<x> == "<value>")`.

**A desktop or window manager.** Add `modules/nixos/desktop/<name>.nix` with
`my.desktop.<name>.enable`, and a profile in `modules/nixos/profiles/` if it comes with a
display manager or apps. Apps live in `apps/`, not under the desktop, so they keep working
when the desktop changes. To theme it, add a target in `modules/nixos/theme/` or
`modules/home/theme/` that reads the same theme data.

**A profile.** Add `modules/nixos/profiles/<name>.nix` declaring `my.profiles.<name>.enable`
and setting other toggles with `lib.mkDefault true`.

**A host.**
1. Create `hosts/<name>/default.nix` (import `./hardware-configuration.nix`, set `hostName`,
   `stateVersion` and the `my.*` toggles) and its `hardware-configuration.nix`.
2. Add `<name> = mkHost { host = "<name>"; users = [ "daniel" ]; };` to `flake.nix`.

**A user.** Copy `users/daniel/` to `users/<newuser>/`, edit the account, toggles and git
identity, then add `"<newuser>"` to the host's `users` list in `flake.nix`.

## Dependencies between modules

- A module never imports another module. When it needs one, it sets that module's toggle with
  `lib.mkDefault` (printing -> avahi), so the host can still override it.
- Hard requirements sit where they are needed: `users/daniel/default.nix` enables
  `my.shell.zsh` because zsh is that user's login shell.
- Integrations only read other modules' options and never set them: the `plasma` theme target
  reads `my.desktop.plasma.enable`, and the user's docker group reads
  `virtualisation.docker.enable`.
- `hardware.firmware` needs unfree packages, which `system.nix` allows. NixOS asserts this if
  you disable one without the other.
