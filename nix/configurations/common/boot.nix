{ pkgs, config, lib, ... }:
{
  # Make the boot sequence quiet & enable the systemd initrd
  boot = {
    consoleLogLevel = 0;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "quiet"
      "rd.udev.log_level=3"
      "splash"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
    ];
    loader.timeout = 0;
    # We need to override Stylix here to keep the splash
    plymouth = lib.mkForce {
      enable = true;
      theme = "bgrt";
    };
  };
}
