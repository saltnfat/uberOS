{
  pkgs,
  inputs,
  lib,
  uberOS,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  inherit (uberOS) clock24h oled;

  # dmsPkg = inputs.dms.packages.${system}.default;
in
{
  # home.packages = [
  #   dmsPkg
  #   pkgs.quickshell # Ensure quickshell is available for the service
  # ];
  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dms-shell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    session = {
      pinnedApps = [
        "thunderbird"
        "steam"
        "thunar"
        "org.gnome.Rhythmbox3"
        "virt-manager"
      ];
    };

    settings = {
      use24HourClock = clock24h;
      dockAutoHide = oled;
      showDock = true;
      dockGroupByApp = true;
      useFahrenheit = true;
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          autoHide = oled;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [
            "music"
            "clock"
            "weather"
          ];
          rightWidgets = [
            "systemTray"
            "clipboard"
            "cpuUsage"
            "memUsage"
            "notificationButton"
            "battery"
            "controlCenterButton"
          ];
          spacing = 4;
          innerPadding = 4;
          bottomGap = 0;
          transparency = 0.84;
          widgetTransparency = 1.0;
          squareCorners = false;
          noBackground = false;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          removeWidgetPadding = false;
          widgetPadding = 8;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1.0;
          borderThickness = 1;
          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1.0;
          widgetOutlineThickness = 1;
          fontScale = 1.06;
          iconScale = 1.06;
          autoHideDelay = 250;
          showOnWindowsOpen = false;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          maximizeDetection = true;
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "workspace";
          shadowIntensity = 0;
          shadowOpacity = 60;
          shadowColorMode = "default";
          shadowCustomColor = "#000000";
          clickThrough = false;

        }
      ];
    };

  };
}
