{
  config,
  lib,
  ...
}:
let
  cfg = config.site.hardware.xbox-wireless-adapter;
in
{
  # usb 1-1: New USB device found, idVendor=045e, idProduct=02e6, bcdDevice= 1.00
  # usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
  # usb 1-1: Product: XBOX ACC
  # usb 1-1: Manufacturer: Microsoft Inc.
  options.site.hardware.xbox-wireless-adapter = {
    enable = lib.mkEnableOption "hardware handling for Xbox Wireless Adapter";
  };

  config = lib.mkIf cfg.enable {
    hardware.xone.enable = true;
  };
}
