{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.site.ozzie;
in
{
  config = lib.mkIf cfg.work {
    home-manager.users.ozzie = {
      home.packages = with pkgs; [
        _1password-gui
        google-chrome
        google-cloud-sdk
        slack
      ];
    };

    programs.chromium = {
      enable = true;

      extraOpts = {
        # Ref https://chromeenterprise.google/policies/
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        AutoplayAllowed = false;
        DefaultBrowserSettingEnabled = false;
        HighEfficiencyModeEnabled = false;
        HttpsOnlyMode = "force_enabled";
        ImportAutofillFormData = false;
        ImportBookmarks = false;
        ImportHistory = false;
        ImportHomepage = false;
        ImportSavedPasswords = false;
        ImportSearchEngine = false;
        PasswordManagerEnabled = false;
      };
    };
  };
}
