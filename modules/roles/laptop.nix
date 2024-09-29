{
  config,
  lib,
  ...
}: {
  options.roles.laptop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Configure as laptop";
  };

  config.site.desktop.gnome.enable = true;
}
