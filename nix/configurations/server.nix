{ pkgs, lib, config, sources, ... }: 
{
  # Store some system metrics
  services.netdata.enable = true;
  services.netdata.config = { ml = { "enabled" = "yes"; }; };

  # Extra Python & system packages required for Netdata to function
  services.netdata.python.extraPackages = ps: [ ps.psycopg2 ];
  systemd.services.netdata = { path = (with pkgs; [ jq ]); };

  # Enable fail2ban for SSH by default
  services.fail2ban.enable = true;
}