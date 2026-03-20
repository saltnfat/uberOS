# SDDM is a display manager for X11 and Wayland
{
  pkgs,
  config,
  lib,
  host,
  ...
}:
let
  foreground = config.stylix.base16Scheme.base00;
  textColor = config.stylix.base16Scheme.base05;
in
{
  config = lib.mkIf (config.uberOS.displayManager == "sddm") {
    services.displayManager = {
      sddm = {
        #package = pkgs.kdePackages.sddm;
        extraPackages = [ pkgs.sddm-astronaut ];
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        settings =
          let
            keyboardLayout = config.uberOS.keyboardLayout;
            keyboardVariant = config.uberOS.keyboardVariant;
          in
          {
            X11 = {
              XkbLayout = keyboardLayout;
              XkbVariant = keyboardVariant;
            };
          };
      };
    };
    environment.systemPackages = with pkgs; [ sddm-astronaut ];

    # Ensure Wayland SDDM also sees XKB defaults
    systemd.services.display-manager.environment =
      let
        keyboardLayout = config.uberOS.keyboardLayout;
        keyboardVariant = config.uberOS.keyboardVariant;
      in
      (
        {
          XKB_DEFAULT_LAYOUT = keyboardLayout;
        }
        // lib.optionalAttrs (keyboardVariant != "") { XKB_DEFAULT_VARIANT = keyboardVariant; }
      );
  };
}
