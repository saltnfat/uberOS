{
  config,
  uberOS,
  username,
  ...
}:
let
  inherit (uberOS) oled;

  lockTimeout = if oled == true then 120 else 350;
  screenTimeout = if oled == true then 0 else 1200; # 1200 is 20 min
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300; # sec before requiring auth
        hide_cursor = true;
        no_fade_in = false;
      };

      ## Leaving background and image settings empty will give us a pure black screen (except for pass field)
      ## This is what we want on an OLED screen

      # OLED friendly dot only input field
      input-field = [
        {
          #size = "200, 50";
          #position = "0, -80";
          size = if oled then "0, 0" else "200, 50";
          position = if oled then "0, 0" else "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = true;
          fade_timeout = 2000;
          font_color = "rgb(CFE6F4)";
          inner_color = "rgb(657DC2)";
          outer_color = "rgb(0D0E15)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
      background =
        if oled then
          [ ]
        else
          [
            {
              path = config.stylix.image;
              blur_passes = 3;
              blur_size = 8;
            }
          ];
      image =
        if oled then
          [ ]
        else
          [
            {
              path = "/home/${username}/.config/face.jpg";
              size = 150;
              border_size = 4;
              border_color = "rgb(0C96F9)";
              rounding = -1; # Negative means circle
              position = "0, 200";
              halign = "center";
              valign = "center";
            }
          ];

    };
  };
}
