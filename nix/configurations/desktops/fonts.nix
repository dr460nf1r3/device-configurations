{ pkgs, config, ... }:
{
  # Font configuration
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      fira
      font-awesome_4
      font-awesome_5
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk
      roboto
    ];
    # My beloved Fira Sans & JetBrains Mono
    fontconfig = {
      cache32Bit = true;
      defaultFonts = {
        monospace = [ "Jetbrains Mono" ];
        sansSerif = [ "Fira" ];
        serif = [ "Fira" ];
      };
    };
  };
}
