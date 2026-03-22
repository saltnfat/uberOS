_: {

  uberOS = {
    # Customize nixos per host in this file
    #
    # For a comprehensive list of all available options, their descriptions,
    # and default values, please refer to the following file:
    # ../../modules/options.nix
    #
    # You can override any of those options here. Most settings are optional
    # and can be removed to use the project defaults.
    username = "non";
    hostname = "nix-lappy";

    # User Variables
    gitUsername = "saltnfat";
    gitEmail = "jwingy@gmail.com";
    gpgSigningKeyId = "67941A938C501A7D";

    # System Settings
    locale = "en_US.UTF-8";
    LCVariables = "en_US.UTF-8";
    timezone = "America/New_York";
    keyboardLayout = "us";
    keyboardVariant = "";
    consoleKeyMap = "us";

    # Set Display Manager
    # `tui` for Text login
    # `sddm` for graphical GUI (default)
    displayManager = "sddm";

    shell = "zsh"; # Possible options: bash, zsh

    gpuProfile = "amd";

    # Only if you set up an encrypted swap partition with LUKS
    # can find the part uuid using the command lsblk -no PARTUUID <device id e.g. /dev/nvme1n1p9>
    #swapPartUUID = "b5d10f90-f4fe-443f-89e2-e764068b8f64";
    #swapLUKSID = "aa3d21ed-9002-40fa-ad02-9c8dd556e8fe";

    # optionally enable another DE / WM
    kdeEnable = false;

    localHardwareClock = false;

    # Enable Printer
    printEnable = false;

    # Enable Support For
    # Logitech Devices
    logitechEnable = true;

    # Enable Terminals
    alacrittyEnable = true;

    # Enable SyncThing
    syncthingEnable = true;

    # Xorg scaling
    x11ScaleFactor = "1.4";

    # Power profiles daemon
    powerprofilesEnable = true;

    # Use lanzaboote for secureboot
    securebootEnable = true;

    # NVME ssd acpi power management workaround
    nvmePowerFixEnable = false;
    pcieASPMDisable = false;

    # For burn in protection on OLED
    oled = true;

    # Install gaming packages and features
    gamingEnable = true;

    #### Hyprland / Wayland #######

    # Choose between noctalia, dms, or waybar
    barChoice = "dms";

    # Waybar Settings (used when barChoice = "waybar")
    clock24h = false;

    # Program Options
    # Set Default Browser (google-chrome-stable for google-chrome)
    # This does NOT install your browser
    # You need to install it by adding it to the `packages.nix`
    # or as a flatpak
    #browser = "firefox";
    browser = "zen-beta";

    # Available Options:
    # Kitty, ghostty, wezterm, aalacrity
    # Note: kitty, wezterm, alacritty have to be enabled in `variables.nix`
    # Setting it here does not enable it. Kitty is installed by default
    terminal = "alacritty"; # Set Default System Terminal

    # Examples:
    # extraMonitorSettings = "monitor = Virtual-1,1920x1080@60,auto,1";
    # extraMonitorSettings = "monitor = HDMI-A-1,1920x1080@60,auto,1";
    # You can configure multiple monitors.
    # Inside the quotes, create a new line for each monitor.
    #monitor = DP-3, 3440x1440@174.96, auto, 1, bitdepth, 10, cm, hdr, sdrbrightness, 1.15, sdrsaturation, 0.80, vrr, 3
    #monitor = DP-3, 3440x1440@174.96, auto, 1, bitdepth, 10, vrr, 3
    extraMonitorSettings = "
    monitor = DP-3, 3440x1440@174.96, auto, 1, bitdepth, 10, cm, hdr, sdrbrightness, 1.15, sdrsaturation, 0.80, vrr, 3

    ";

    # Themes, waybar and animation.
    # Only uncomment your selection - The others much be commented out.

    # Set Stylix Image
    # This will set your color palette
    # Default background
    # Add new images to ~/uberOS/wallpapers
    stylixImage = ../../wallpapers/mountainscapedark.jpg;
    #stylixImage = ../../../wallpapers/AnimeGirlNightSky.jpg;
    #stylixImage = ../../../wallpapers/Anime-Purple-eyes.png;
    #stylixImage = ../../../wallpapers/Rainnight.jpg;
    #stylixImage = ../../../wallpapers/zaney-wallpaper.jpg;
    #stylixImage = ../../../wallpapers/nix-wallpaper-stripes-logo.png;
    #stylixImage = ../../../wallpapers/beautifulmountainscape.jpg;

    # Set Waybar
    #  Available Options:
    waybarChoice = ../../home/waybar/waybar-curved.nix;

    # Set Animation style
    # Available options are:
    animChoice = ../../home/hyprland/animations/animations-def.nix;
    #animChoice = ../../modules/home/hyprland/animations-end4.nix;
    #animChoice = ../../modules/home/hyprland/animations-end4-slide.nix;
    #animChoice = ../../modules/home/hyprland/animations-end-slide.nix;
    #animChoice = ../../modules/home/hyprland/animations-dynamic.nix;
    #animChoice = ../../modules/home/hyprland/animations-moving.nix;
    #animChoice = ../../modules/home/hyprland/animations-hyde-optimized.nix;
    #animChoice = ../../modules/home/hyprland/animations-mahaveer-me-1.nix;
    #animChoice = ../../modules/home/hyprland/animations-mahaveer-me-2.nix;
    #animChoice = ../../modules/home/hyprland/animations-ml4w-classic.nix;
    #animChoice = ../../modules/home/hyprland/animations-ml4w-fast.nix;
    #animChoice = ../../modules/home/hyprland/animations-ml4w-high.nix;
  };
}
