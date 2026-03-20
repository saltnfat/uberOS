{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      cherry
      clarity-city
      cozette
      maple-mono.NF
      terminus_font
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.inconsolata
      nerd-fonts.jetbrains-mono
      nerd-fonts.monofur
      nerd-fonts.mononoki
      nerd-fonts.ubuntu-sans

      # Meh don't use
      #nerd-fonts.noto
      #nerd-fonts.recursive-mono

      # (nerdfonts.override {
      #   fonts = [
      #     "JetBrainsMono"
      #     "Terminus"
      #     "Inconsolata"
      #   ];
      # })
    ];
  };
}
