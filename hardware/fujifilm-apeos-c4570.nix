{
  config,
  lib,
  ...
}:
let
  cfg = config.site.hardware.fujifilm-apeos-c4570;
in
{
  options.site.hardware.fujifilm-apeos-c4570 = {
    enable = lib.mkEnableOption "hardware handling for Fujifilm Apeos C4570";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      printers = {
        ensureDefaultPrinter = "Fujifilm-Apeos-C4570";

        ensurePrinters = [
          {
            deviceUri = "ipp://192.168.2.2/ipp/print";
            location = "Work";
            model = "everywhere";
            name = "Fujifilm-Apeos-C4570";
            ppdOptions.PageSize = "A4";
          }
        ];
      };
    };
  };
}
