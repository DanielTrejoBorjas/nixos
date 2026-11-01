{ ... }:

{
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "es_ES.UTF-8";

  # Spanish keyboard (X11/Wayland + TTY)
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };
  console.useXkbConfig = true;
}
