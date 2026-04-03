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
    alacritty.enable = true;
    btop.enable = true;
    kitty.enable = true;
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
    neovim.enable = false;
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
    # schemes here https://tinted-theming.github.io/tinted-gallery/
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-dune-light.yaml";
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
