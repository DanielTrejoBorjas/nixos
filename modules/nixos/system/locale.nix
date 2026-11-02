{ config, lib, ... }:

let
  cfg = config.my.locale;
in
{
  options.my.locale = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/Madrid";
    };

    language = lib.mkOption {
      type = lib.types.str;
      default = "es_ES.UTF-8";
    };

    keyboardLayout = lib.mkOption {
      type = lib.types.str;
      default = "es";
      description = "XKB layout, used by X11/Wayland and the TTY.";
    };
  };

  config = {
    time.timeZone = cfg.timeZone;
    i18n.defaultLocale = cfg.language;

    services.xserver.xkb.layout = cfg.keyboardLayout;
    console.useXkbConfig = true;
  };
}
