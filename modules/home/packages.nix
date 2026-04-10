{
  pkgs,
  config,
  uberOS,
  ...
}:

let
  inherit (uberOS) barChoice;
  # Noctalia-specific packages
  noctaliaPkgs =
    if barChoice == "noctalia" then
      with pkgs;
      [
        matugen # color palette generator needed for noctalia-shell
        app2unit # launcher for noctalia-shell
        gpu-screen-recorder # needed for nnoctalia-shell
      ]
    else
      [ ];
in
{
  # Install Packages For The User
  home.packages =
    with pkgs;
    noctaliaPkgs
    ++ [

      # Hyprland
      cliphist
      rofi
      dmenu
      jq
      ranger
      ueberzug

      # audio related
      libmpdclient
      playerctl
      mpd
      mpc
      pamixer

      # dev related
      age
      alacritty
      kitty
      geany
      libvirt
      maim
      papirus-icon-theme
      joypixels
      zig
      gcc
      lazygit
      xclip
      zoxide
      fzf
      fd
      sesh
      docker
      mysql-workbench
      delta

      # zsh related
      zsh
      zsh-autosuggestions
      zsh-history-substring-search
      zsh-syntax-highlighting
      zsh-autocomplete
      zsh-fzf-tab

      # image related
      gdk-pixbuf
      webp-pixbuf-loader
      imagemagick
      libwebp
      feh
      gimp3-with-plugins
      inkscape-with-extensions

      # other
      nh
      tor-browser
      networkmanagerapplet
      thunderbird
      inetutils
      remmina
      keepassxc
      libreoffice
      evince # for pdfs
      nix-sweep # clean up nix profile generations and left over gc roots
      qtox
      qbittorrent
      #tribler # another torrent client
      clamtk
      element-desktop
      cryfs
      cobang # qr scanner from webcam
      motrix # download manager

    ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gh.enable = true;
  };
}
