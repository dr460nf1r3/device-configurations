{ pkgs, inputs, ... }:
{
  # Spotify via spotify-tui & spotifyd
  services.spotifyd = {
    enable = true;
    settings.global = {
      autoplay = true;
      backend = "alsa";
      bitrate = 320;
      cache_path = "/var/cache/spotifyd";
      control = "alsa_audio_device";
      dbus_type = "session";
      device = "alsa_audio_device";
      device_name = "NixOS";
      device_type = "speaker";
      initial_volume = "90";
      max_cache_size = 1000000000;
      mixer = "PCM";
      normalisation_pregain = -10;
      password_cmd = "cat /var/persistent/pass/spot";
      use_mpris = true;
      username = "spotify@dr460nf1r3.org";
      volume_controller = "alsa";
      volume_normalisation = true;
      zeroconf_port = 1234;
    };
  };

  # Waydroid for Android apps
  virtualisation.waydroid.enable = true;
}
