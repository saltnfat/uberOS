{
  pkgs,
  lib,
  uberOS,
  ...
}:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = lib.mkIf (
        uberOS ? mimeDefaultApps && uberOS.mimeDefaultApps != { }
      ) uberOS.mimeDefaultApps;

      # Examples: uncomment to set defaults here (host-level preferred via uberOS.mimeDefaultApps)
      # defaultApplications = {
      #   # PDFs
      #   "application/pdf" = ["okular.desktop"];      # change to your preferred reader
      #   "application/x-pdf" = ["okular.desktop"];    # legacy alias
      #
      #   # Web browser
      #   "x-scheme-handler/http"  = ["google-chrome.desktop"];  # or brave-browser.desktop, firefox.desktop, etc.
      #   "x-scheme-handler/https" = ["google-chrome.desktop"];
      #   "text/html"              = ["google-chrome.desktop"];
      #
      #   # Text files
      #   "text/plain" = ["nvim.desktop"];             # or code.desktop, org.gnome.TextEditor.desktop
      #
      #   # Images and video
      #   "image/png" = ["imv.desktop"];               # or org.gnome.eog.desktop
      #   "video/mp4" = ["mpv.desktop"];               # or vlc.desktop
      #
      #   # Archives
      #   "application/zip" = ["org.gnome.FileRoller.desktop"]; # or xarchiver.desktop, peazip.desktop
      #
      #   # Folders (file manager)
      #   "inode/directory" = ["thunar.desktop"];      # or org.gnome.Nautilus.desktop, org.kde.dolphin.desktop
      # };
    };
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.hyprland ];
    };
  };
}
