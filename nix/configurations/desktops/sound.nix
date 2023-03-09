{ pkgs, config, ... }:
{
  # Enable sound with Pipewire
  environment.variables = {
    SDL_AUDIODRIVER = "pipewire";
    ALSOFT_DRIVERS = "pipewire";
  };
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    enable = true;
    media-session.enable = false;
    pulse.enable = true;
    systemWide = false;
    wireplumber.enable = true;
  };
  sound.enable = true;
}
