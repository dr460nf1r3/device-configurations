{ pkgs, ... }:
{
  # MangoHUD to monitor performance while gaming
  programs.mangohud = {
    enable = true;
    settings = {
      arch = true;
      background_alpha = "0.05";
      battery = true;
      cpu_temp = true;
      engine_version = true;
      font_size = 17;
      fps_limit = 60;
      gl_vsync = 0;
      gpu_name = true;
      gpu_temp = true;
      io_read = true;
      io_write = true;
      position = "top-right";
      round_corners = 8;
      vram = true;
      vsync = 1;
      vulkan_driver = true;
      width = 260;
      wine = true;
    };
  };

  # MPV configuration
  programs.mpv = {
    enable = true;
    config = {
      # Temporary & lossless screenshots
      screenshot-format = "png";
      screenshot-directory = "/tmp";
      # for Pipewire (Let's pray for MPV native solution)
      ao = "openal";
      audio-channels = "stereo";
      # GPU & Wayland
      hwdec = "vaapi";
      vo = "gpu";
      gpu-api = "vulkan";
      # YouTube quality
      ytdl-format = "bestvideo[height<=?2160]+bestaudio/best";
    };
  };

  # Alacritty, the terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "Jetbrains Mono Nerd Font"; };
        size = 11.0;
      };
      window.opacity = 0.9;
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };
    };
  };
}
