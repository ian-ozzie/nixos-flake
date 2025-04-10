{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.hardware.openterface-mini-kvm;
in
{
  options.site.hardware.openterface-mini-kvm = {
    enable = lib.mkEnableOption "hardware handling for Openterface Mini-KVM";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openterface-qt
    ];
  };
}
