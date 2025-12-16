{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.roles.laptop;
in
{
  options.site.roles.laptop = {
    enable = lib.mkEnableOption "laptop role";
  };

  config = lib.mkIf cfg.enable {
    powerManagement.cpuFreqGovernor = "powersave";
    site.roles.gui.enable = true;

    environment.systemPackages = with pkgs; [
      cpupower-gui
    ];

    services = {
      cpupower-gui.enable = true;
    };
  };
}
