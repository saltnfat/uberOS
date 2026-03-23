{
  pkgs,
  host,
  config,
  ...
}:
let
  inherit (config.uberOS) stylixImage;
in
{
  hm.stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
    ghostty.enable = false;
    neovim.enable = false;
    alacritty.enable = true;
    firefox.enable = false;
    tmux.enable = false;
    qt = {
      enable = true;
      platform = "qtct";
    };
  };
  # Styling Options
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = stylixImage;
    polarity = "dark";
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      # sansSerif = {
      #   package = pkgs.montserrat;
      #   name = "Montserrat";
      # };
      # serif = {
      #   package = pkgs.montserrat;
      #   name = "Montserrat";
      # };
      sizes = {
        applications = 12;
        terminal = 11.5;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
