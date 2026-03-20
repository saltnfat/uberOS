{
  inputs,
  config,
  ...
}:

let
  inherit (config.uberOS)
    consoleKeyMap
    locale
    timezone
    LCVariables
    ;
in
{
  # Set your time zone
  time.timeZone = "${timezone}";

  # Select internationalisation properties
  i18n.defaultLocale = "${locale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${LCVariables}";
    LC_IDENTIFICATION = "${LCVariables}";
    LC_MEASUREMENT = "${LCVariables}";
    LC_MONETARY = "${LCVariables}";
    LC_NAME = "${LCVariables}";
    LC_NUMERIC = "${LCVariables}";
    LC_PAPER = "${LCVariables}";
    LC_TELEPHONE = "${LCVariables}";
    LC_TIME = "${LCVariables}";
  };

  console.keyMap = "${consoleKeyMap}";

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    #POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      #substituters = ["https://hyprland.cachix.org"];
      #trusted-public-keys = [
      #  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      #];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    #extraOptions = "!include ${config.sops.secrets.access-tokens.path}";
  };

  system.stateVersion = "23.11";
}
