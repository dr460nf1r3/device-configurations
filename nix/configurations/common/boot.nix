{ pkgs, config, ... }:
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
      "splash"
      "vt.global_cursor_default=0"
      #"rd.udev.log_level=3"
      #"udev.log_priority=3"
    ];
    loader.timeout = 0;
  };
}
